# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'activeadmin'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', github: 'heartcombo/devise', branch: 'ca-omniauth-2'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'faker'
gem 'haml-rails'
gem 'i18n'
gem 'jbuilder', '~> 2.7'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-rails_csrf_protection'
gem 'pagy', '~> 3.5'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit'
gem 'rails', '~> 6.1.3'
gem 'rubocop-rails',  require: false
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'
group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'database_cleaner-active_record'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webdrivers'
end
