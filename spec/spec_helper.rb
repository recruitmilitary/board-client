$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'board-client'
require 'spec'
require 'spec/autorun'
require 'webmock/rspec'

require 'yajl/json_gem' # required for webmock

Spec::Runner.configure do |config|
  config.include WebMock
end
