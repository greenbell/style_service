require 'rubygems'
require 'bundler'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

Bundler.setup
Bundler.require

desc 'Default: run unit tests.'
task :default => :spec

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc 'Generate documentation for the style_service plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'StyleService'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
