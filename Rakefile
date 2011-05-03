require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "board-client"
    gem.summary = %Q{A ruby wrapper for the board platform}
    gem.description = %Q{A ruby wrapper for the board platform.}
    gem.email = "mguterl@gmail.com"
    gem.homepage = "http://github.com/mguterl/board-client"
    gem.authors = ["Michael Guterl"]
    gem.add_dependency "rest-client", "~> 1.6.1"
    gem.add_dependency "yajl-ruby", "~> 0.7.7"
    gem.add_development_dependency "rspec", "~> 1.3.0"
    gem.add_development_dependency "webmock", "~> 1.6.2"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "board-client #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
