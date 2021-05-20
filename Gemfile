source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'jbuilder', '~> 2.7'
gem 'mysql2'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0.3'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

# Active Storage S3
gem 'aws-sdk-s3', require: false

# Device
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'

# bootstrap
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'sassc', '~> 2.3.0'
gem 'uglifier'

gem 'jquery-rails'
gem 'kaminari'

gem 'dotenv-rails'
gem 'ransack'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 4.11'
  gem 'faker'
  gem 'pry-rails'
  gem 'rb-readline'
  gem 'rspec-rails', '~> 3.7'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  # deviseメール認証機能確認gem
  gem 'letter_opener_web'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers', require: !ENV['SELENIUM_REMOTE_URL']
  gem 'rspec_junit_formatter'
end
