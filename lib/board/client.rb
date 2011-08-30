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

    BadRequest          = Class.new(Error)
    Unauthorized        = Class.new(Error)
    Forbidden           = Class.new(Error)
    NotFound            = Class.new(Error)
    NotAcceptable       = Class.new(Error)
    Conflict            = Class.new(Error)
    UnprocessableEntity = Class.new(Error)
    InternalServerError = Class.new(Error)
    NotImplemented      = Class.new(Error)
    BadGateway          = Class.new(Error)
    ServiceUnavailable  = Class.new(Error)

    include Request

    class << self
      attr_accessor :default_endpoint
    end
    self.default_endpoint = 'https://board.recruitmilitary.com/api/v1'

    def initialize(api_key, endpoint = Client.default_endpoint, options = {})
      @api_key  = api_key
      @endpoint = endpoint
      @ssl      = options[:ssl] || {}
    end

    autoload :API, 'board/client/api'
    autoload :Users, 'board/client/users'
    autoload :Candidates, 'board/client/candidates'
    autoload :Organizations, 'board/client/organizations'
    autoload :UserOrganizations, 'board/client/user_organizations'

    def users
      Users.new(self)
    end

    def candidates
      Candidates.new(self)
    end

    def organizations
      Organizations.new(self)
    end

    def user_organizations
      UserOrganizations.new(self)
    end

  end
end
