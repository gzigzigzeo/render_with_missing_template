# encoding: UTF-8
require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "render_with_missing_template"
    gem.summary = "Extends rails render method to accept default template when expected template is missing"
    gem.description = "Extends rails render method to render default template when expected template is missing"
    gem.files =  FileList["[A-Z]*", "lib/**/*"]
    gem.version = "0.0.1"
    gem.email = "gzigzigzeo@gmail.com"
    gem.authors = ["Victor Sokolov"]
    gem.homepage = "git://github.com/gzigzigzeo/render_with_missing_template.git"
            
    gem.add_dependency "rails", ">= 3.0.0"    
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end