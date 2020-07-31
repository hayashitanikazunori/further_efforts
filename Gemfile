source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 6.0.3'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

# Active Storage S3
gem 'aws-sdk-s3', require: false

# Device
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-google-oauth2'

# bootstrap
gem 'sassc', '~> 2.3.0'
gem 'uglifier'
gem 'bootstrap'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'bootsnap', '>= 1.4.2', require: false

gem 'jquery-rails'
gem 'kaminari'

gem 'ransack'
gem 'dotenv-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.7'
  gem 'factory_bot_rails', '~> 4.11'
  gem 'faker'
  gem 'pry-rails'
  gem 'rb-readline'
  # gem 'bullet' # N+1問題ハリボテが終わったら解決に入る
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # deviseメール認証機能確認gem
  gem 'letter_opener_web'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end