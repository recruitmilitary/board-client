# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "board/client/version"

Gem::Specification.new do |s|
  s.name        = "board-client"
  s.version     = Board::Client::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michael Guterl"]
  s.email       = ["mguterl@gmail.com"]
  s.homepage    = "http://github.com/recruitmilitary/board-client"
  s.summary     = %q{A ruby wrapper for the RecruitMilitary Board HTTP API}
  s.description = %q{A ruby wrapper for the RecruitMilitary Board HTTP API}

  s.rubyforge_project = "board-client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rest-client', '~> 1.6.1'
  s.add_dependency 'yajl-ruby',   '~> 0.7.7'
  s.add_dependency 'hashie',      '~> 1.2.0'
  s.add_dependency 'certified',   '~> 0.1.1'

  s.add_development_dependency 'rspec', '~> 2.6.0'
  s.add_development_dependency 'vcr', '~> 1.11.1'
  s.add_development_dependency 'webmock', '~> 1.7.4'
  s.add_development_dependency 'ruby-debug'
end
