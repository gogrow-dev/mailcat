# frozen_string_literal: true

require "mailcat/delivery_method"
require "mailcat/railtie" if defined?(Rails::Railtie)
require "mailcat/version"

module Mailcat
  class Error < StandardError; end

  class Configuration
    attr_accessor :mailcat_api_key, :mailcat_url

    def initialize
      @mailcat_api_key = ENV["MAILCAT_API_KEY"]
      @mailcat_url     = ENV["MAILCAT_URL"]
    end
  end

  class << self
    def config
      @config ||= Configuration.new
    end

    def configure
      yield config
    end
  end
end
