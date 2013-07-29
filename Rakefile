#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

app_rakefile_name = "../spec/dummy/Rakefile"
if File.exists? app_rakefile_name
  APP_RAKEFILE = File.expand_path(app_rakefile_name, __FILE__)
  load 'rails/tasks/engine.rake'
end


Bundler::GemHelper.install_tasks

require 'rake/testtask'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "features --format pretty"
end

RSpec::Core::RakeTask.new(:spec)

task :default => [:cucumber, :spec]
