# frozen_string_literal: true

RSpec.describe Mailcat do
  it "has a version number" do
    expect(Mailcat::VERSION).not_to be nil
  end

  describe "configuration" do
    context "when using the default environment variables" do
      before do
        Mailcat.instance_variable_set(:@config, nil)
        stub_const("ENV", ENV.to_h.merge(
                            "MAILCAT_API_KEY" => "spec_key",
                            "MAILCAT_URL" => "https://spec-url.com"
                          ))
      end

      it "uses ENV defaults if not explicitly set" do
        expect(Mailcat.config.mailcat_api_key).to eq("spec_key")
        expect(Mailcat.config.mailcat_url).to eq("https://spec-url.com")
      end
    end

    context "when explicitly set" do
      before do
        Mailcat.instance_variable_set(:@config, nil)
        described_class.configure do |config|
          config.mailcat_api_key = "explicit_key"
          config.mailcat_url = "https://explicit-url.com"
        end
      end

      it "uses explicitly set values" do
        expect(Mailcat.config.mailcat_api_key).to eq("explicit_key")
        expect(Mailcat.config.mailcat_url).to eq("https://explicit-url.com")
      end
    end
  end
end
