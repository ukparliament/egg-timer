require 'capybara/rspec'
require 'selenium/webdriver'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :headless_chrome
  end

  config.before(:each, type: :system, js: true, chrome: true) do
    driven_by :chrome
  end

  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new

    %w[
      incognito
      disable-extensions
      window-size=1920,1920
      headless
      disable-gpu
    ].each { options.add_argument _1 }

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: options
    )
  end

  Capybara.register_driver :chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: options
    )
  end

  Capybara.default_driver = :chrome
  Capybara.server = :puma, { Silent: true }
end
