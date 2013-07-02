source "http://rubygems.org"
gemspec

gem 'jquery-rails'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-github'

group :development do
  gem 'guard'
  gem 'guard-rspec'
end

group :test do
  gem 'database_cleaner', require: false
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
end
