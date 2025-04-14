# frozen_string_literal: true

module Mailcat
  # Rails delivery_method for Mailcat.
  class DeliveryMethod
    attr_accessor :settings

    def initialize(...)
      self.settings = Mailcat.config
    end

    def deliver!(mail)
      send_to_mailcat(mail)
    end

    private

    def send_to_mailcat(mail)
      email_content, attachments_ids = process_attachments(mail)

      Net::HTTP.start(emails_uri.hostname, emails_uri.port, use_ssl: emails_uri.scheme == "https") do |http|
        req = Net::HTTP::Post.new(emails_uri)
        req["Content-Type"] = "application/json"
        req["X-Api-Key"] = Mailcat.mailcat_api_key_raw
        email_body = {
          from: mail.from.first,
          to: mail.to,
          bcc: mail.bcc,
          cc: mail.cc,
          subject: mail.subject,
          attachments: attachments_ids,
          **email_content
        }

        req.body = { email: email_body }.to_json

        http.request(req)
      end
    end

    def process_attachments(mail)
      processed_email = {}
      processed_email["html_content"] = mail.html_part.body.raw_source if mail.html_part
      processed_email["text_content"] = mail.text_part.body.raw_source if mail.text_part
      processed_email["html_content"] ||= mail.body.raw_source

      attachments_ids = mail.attachments.map do |attachment|
        upload_attachment(attachment).tap do |blob_id|
          %w[html_content text_content].each do |content_type|
            next unless processed_email[content_type].present?

            processed_email[content_type].gsub!(attachment.url, "mailcat://#{blob_id}")
          end
        end
      end

      [processed_email, attachments_ids]
    end

    def upload_attachment(attachment)
      file = attachment_tempfile(attachment)

      req = Net::HTTP::Post.new(direct_uploads_uri)
      req["Content-Type"] = "application/json"
      req["X-Api-Key"] = Mailcat.mailcat_api_key_raw
      req.body = {
        blob: {
          filename: attachment.filename,
          content_type: attachment.content_type,
          byte_size: file.size,
          checksum: Digest::MD5.file(file).base64digest
        }
      }

      res = Net::HTTP.start(direct_uploads_uri.hostname, direct_uploads_uri.port, use_ssl: false) do |http|
        http.request(req)
      end

      JSON.parse(res.body)["id"]
    ensure
      file&.close
    end

    def emails_uri
      @emails_uri ||= URI("#{Mailcat.mailcat_url_raw}/api/emails")
    end

    def direct_uploads_uri
      @direct_uploads_uri ||= URI("#{Mailcat.mailcat_url_raw}/api/direct_uploads")
    end

    def attachment_tempfile(attachment)
      Tempfile.new(attachment.filename).tap do |file|
        file.binmode
        file.write(attachment.body.raw_source)
        file.rewind
      end
    end
  end
end
