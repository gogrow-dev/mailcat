# frozen_string_literal: true

require "mailcat/delivery_method"
require "mailcat/railtie" if defined?(Rails::Railtie)
require "mailcat/version"
require "active_support"

module Mailcat
  class Error < StandardError; end

  include ::ActiveSupport::Configurable

  config_accessor :mailcat_api_key, default: ENV["MAILCAT_API_KEY"]
  config_accessor :mailcat_url, default: ENV["MAILCAT_URL"]
end
