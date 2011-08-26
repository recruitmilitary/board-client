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

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :default => :spec
