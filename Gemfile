# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'activeadmin'
gem 'activeadmin_addons'
gem 'activeadmin_quill_editor'
gem 'active_storage_variant'
gem 'acts_as_list'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.4', require: false
gem 'capistrano', '~> 3.11',  require: false
gem 'capistrano-bundler', require: false
gem 'capistrano-passenger', '~> 0.2.0',  require: false
gem 'capistrano-rails', '~> 1.4',  require: false
gem 'capistrano-rvm',  require: false
gem 'carrierwave', '~> 2.0'
gem 'carrierwave-aws'
gem 'devise'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'draper'
gem 'exception_notification'
gem 'font-awesome-rails'
gem 'friendly_id', '~> 5.4.0'
gem 'haml-rails'
gem 'httparty'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails'
gem 'meta-tags'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-rails_csrf_protection'
gem 'pg', '~> 1.3'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3'
gem 'react-rails'
gem 'redis', '~> 4.0'
gem 'sass-rails', '>= 6'
gem 'sitemap_generator'
gem 'turbolinks', '~> 5'
gem 'twitter-bootstrap-rails'
gem 'webpacker', '~> 5.0'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry', '~> 0.13.1'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'bullet'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'database_cleaner-active_record'
  gem 'rails-controller-testing'
  gem 'resque-scheduler-web', require: false
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webdrivers'
end
