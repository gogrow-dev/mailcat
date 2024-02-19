# frozen_string_literal: true

require "active_support"
require "mailcat/delivery_method"
require "mailcat/railtie" if defined?(Rails::Railtie)

module Mailcat
  # Mailcat railtie to add mailcat delivery method to ActionMailer on Rails app boot
  class Railtie < Rails::Railtie
    initializer "mailcat.add_delivery_method" do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method :mailcat, Mailcat::DeliveryMethod
      end
    end
  end
end
