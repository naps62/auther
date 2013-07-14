source "http://rubygems.org"
gemspec

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-cucumber'
end

group :test do
  gem 'database_cleaner', require: false
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
end
