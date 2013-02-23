#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'bundler'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec)
task default: :spec

#require 'rake/testtask'
#
#Rake::TestTask.new do |t|
#  t.libs.push "lib"
#  t.test_files = FileList['specs/**/*_spec.rb']
#  t.verbose = true
#end

