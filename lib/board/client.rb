require 'yajl'
require 'hashie/mash'

require 'board/client/version'
require 'board/client/request'

module Board
  class Client

    class Error < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
      end
    end

    NotFound = Class.new(Error)
    Conflict = Class.new(Error)

    include Request

    class << self
      attr_accessor :default_endpoint
    end
    self.default_endpoint = 'https://board.recruitmilitary.com/api/v1'

    def initialize(api_key, endpoint = Client.default_endpoint)
      @api_key  = api_key
      @endpoint = endpoint
    end

    autoload :API, 'board/client/api'
    autoload :Users, 'board/client/users'
    autoload :Candidates, 'board/client/candidates'

    def users
      Users.new(self)
    end

    def candidates
      Candidates.new(self)
    end

  end
end
