source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"
gem "rails", "~> 7.0.8", ">= 7.0.8.4"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "jbuilder"
gem 'devise'
gem 'devise_token_auth'
gem 'active_model_serializers'
gem 'rack-cors'
gem 'redis-rails'
gem 'redis'

group :development, :test do
  gem 'dotenv-rails'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 5.0'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers', '~> 5.0'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rails-controller-testing'
end
