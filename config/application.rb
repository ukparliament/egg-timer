require File.expand_path('../boot', __FILE__)

require "rails"

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ParliamentCalendar
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # If running scaffold, don't generate all the stuff which isn't used
    config.generators do |g|
      g.test_framework nil
      g.assets false
      g.helper false
      g.stylesheets false
      g.javascripts false
      g.jbuilder false
      g.system_tests = nil
    end
  end
end
