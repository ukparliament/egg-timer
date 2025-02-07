source 'https://rubygems.org'

ruby '3.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.2.2.1'
gem 'puma'
gem 'pg'

# Required for this version of Ruby and Rails combo
gem 'bigdecimal'
gem 'benchmark'
gem 'csv'

# Nonsense required
gem 'net-protocol'
gem 'net-smtp'
gem 'net-pop'

# For talking to the calendars
# gem 'google-api-client', '~> 0.34'
gem 'google-apis-calendar_v3'

# For markdown rendering
gem 'redcarpet', '3.6.0'

gem 'nokogiri'

# For emails
gem 'postmark-rails'
gem 'dotenv'
gem 'amazing_print'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
  gem 'letter_opener'
end

group :test do
  gem 'capybara'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
end
