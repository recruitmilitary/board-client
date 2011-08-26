$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'board-client'
require 'rspec'
require 'webmock/rspec'
require 'yajl/json_gem' # required for webmock

RSpec.configure do |config|
  config.include WebMock::API
end
