source 'https://rubygems.org'

ruby '3.4.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8'
gem 'puma'
gem 'pg'

# Required for this version of Ruby and Rails combo
gem 'bigdecimal'
gem 'benchmark'
gem 'csv'

# Best add explicitly
gem 'irb'

# For talking to the calendars
gem 'google-apis-calendar_v3'

# For markdown rendering
gem 'redcarpet'

# For nokogiri sort of stuff
gem 'nokogiri'

# For emails
gem 'postmark-rails'

# For using .env
gem 'dotenv'

# For debug
gem 'amazing_print'
gem 'lograge'

# Annotate models
gem 'annotaterb'

# For exception handling
gem 'rollbar'

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
