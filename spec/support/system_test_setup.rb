require 'capybara/rspec'
require 'selenium/webdriver'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, chrome: true) do
    driven_by :chrome
  end

  Capybara.register_driver :chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: options
    )
  end

  Capybara.default_driver = :rack_test
  Capybara.server = :puma, { Silent: true }
end
