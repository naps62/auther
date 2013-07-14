#!/usr/bin/env rake
# encoding: utf-8

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'bundler/gem_tasks'
require 'rake'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'appraisal'

desc 'Default'
task :default => [:all]

desc 'Test the engine under all supported Rails versions'
task :all => ['appraisal:install'] do |t|
  exec 'rake appraisal spec cucumber'
end

RSpec::Core::RakeTask.new(:spec)

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.fork = false
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'pretty')]
end
