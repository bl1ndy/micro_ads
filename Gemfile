# frozen_string_literal: true

source 'https://rubygems.org'

# WEB
gem 'puma', '~> 6.3'
gem 'rake', '~> 13.0', '>= 13.0.6'
gem 'sinatra', '~> 3.0', '>= 3.0.6', require: 'sinatra/base'
gem 'sinatra-contrib', '~> 3.0', '>= 3.0.6'

# DB/ORM/Model
gem 'dry-initializer', '~> 3.1', '>= 3.1.1'
gem 'dry-validation', '~> 1.10'
gem 'pg', '~> 1.5', '>= 1.5.3'
gem 'sequel', '~> 5.69'

# Configuration
gem 'config', '~> 4.2'

# Tools
gem 'activesupport', '~> 7.0', '>= 7.0.5', require: false
gem 'fast_jsonapi', '~> 1.5'
gem 'i18n', '~> 1.14'

group :development do
  gem 'rubocop', '~> 1.52', require: false
  gem 'rubocop-performance', '~> 1.18', require: false
  gem 'rubocop-rspec', '~> 2.22', require: false
  gem 'rubocop-sequel', '~> 0.3.4', require: false
end

group :test do
  gem 'database_cleaner-sequel', '~> 2.0', '>= 2.0.2'
  gem 'factory_bot', '~> 6.2', '>= 6.2.1'
  gem 'rack-test', '~> 2.1'
  gem 'rspec', '~> 3.12'
end
