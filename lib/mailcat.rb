# frozen_string_literal: true

require "mailcat/delivery_method"
require "mailcat/railtie" if defined?(Rails::Railtie)
require "mailcat/version"
require "active_support/core_ext/module/attribute_accessors"

module Mailcat
  class Error < StandardError; end

  mattr_accessor :mailcat_api_key, default: -> { ENV["MAILCAT_API_KEY"] }
  mattr_accessor :mailcat_url, default: -> { ENV["MAILCAT_URL"] }

  def self.configure
    yield self
  end

  def self.mailcat_api_key_raw
    mailcat_api_key.is_a?(Proc) ? mailcat_api_key.call : mailcat_api_key
  end

  def self.mailcat_url_raw
    mailcat_url.is_a?(Proc) ? mailcat_url.call : mailcat_url
  end
end
