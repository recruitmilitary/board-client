require 'yajl'

require 'board/request'
require 'board/candidate_search'

module Board
  class Client

    include Request

    class << self
      attr_accessor :default_url
    end
    self.default_url = 'https://board.recruitmilitary.com/api/v1'

    def initialize(api_key, url = Client.default_url)
      @api_key = api_key
      @url     = url
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

  end
end
