require 'yajl'
require 'hashie/mash'

require 'board/client/version'
require 'board/request'
require 'board/candidate_search'

module Board
  class Client

    include Request

    class << self
      attr_accessor :default_endpoint
    end
    self.default_endpoint = 'https://board.recruitmilitary.com/api/v1'

    def initialize(api_key, endpoint = Client.default_endpoint)
      @api_key  = api_key
      @endpoint = endpoint
    end

    def candidate_searches(params)
      get "/candidate_searches", params
    end

    def find_user(params)
      get "/users", params
    end

    def mark_user_invalid(params)
      get "/users/invalid", params
    end

    def unsubscribe(params)
      get "/users/unsubscribe", params
    end

    def create_candidate_invitation(params)
      post "/candidate_invitations", params
    end

    def find_candidate(candidate_id)
      get "/candidates/#{candidate_id}", {}
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
