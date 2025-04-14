# frozen_string_literal: true

RSpec.describe Mailcat do
  it "has a version number" do
    expect(Mailcat::VERSION).not_to be nil
  end

  describe "environment variable loader" do
    context "when using the default environment variables" do
      before do
        stub_const("ENV", ENV.to_h.merge(
                            "MAILCAT_API_KEY" => "spec_key",
                            "MAILCAT_URL" => "https://spec-url.com"
                          ))
      end

      it "uses ENV defaults if not explicitly set" do
        expect(Mailcat.mailcat_api_key_raw).to eq("spec_key")
        expect(Mailcat.mailcat_url_raw).to eq("https://spec-url.com")
      end
    end

    context "when explicitly set" do
      before do
        described_class.configure do |config|
          config.mailcat_api_key = "explicit_key"
          config.mailcat_url = "https://explicit-url.com"
        end
      end

      it "uses explicitly set values" do
        expect(Mailcat.mailcat_api_key_raw).to eq("explicit_key")
        expect(Mailcat.mailcat_url_raw).to eq("https://explicit-url.com")
      end
    end
  end
end
