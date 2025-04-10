# frozen_string_literal: true

require "mailcat/delivery_method"
require "mailcat/railtie" if defined?(Rails::Railtie)
require "mailcat/version"
require "active_support"

module Mailcat
  class Error < StandardError; end

  include ::ActiveSupport::Configurable

  config_accessor :mailcat_api_key, default: -> { ENV["MAILCAT_API_KEY"] }
  config_accessor :mailcat_url, default: -> { ENV["MAILCAT_URL"] }

  def self.mailcat_api_key_raw
    config.mailcat_api_key.is_a?(Proc) ? config.mailcat_api_key.call : config.mailcat_api_key
  end

  def self.mailcat_url_raw
    config.mailcat_url.is_a?(Proc) ? config.mailcat_url.call : config.mailcat_url
  end
end
