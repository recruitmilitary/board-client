require 'rubygems'
require 'bundler/setup'

require 'rest_client'
require 'yajl'

require 'board/api'

module Board

  autoload :CandidateSearch, 'board/candidate_search'

  class Client

    class << self
      attr_accessor :default_url
    end
    self.default_url = 'https://board.recruitmilitary.com/api/v1'

    def initialize(api_key, url = Client.default_url)
      @api_key = api_key
      @url     = url
    end

    def candidate_invitations
      @candidate_invitations ||= API::CandidateInvitations.new(@api_key, @url)
    end

    def users
      @users ||= API::Users.new(@api_key, @url)
    end

    def candidate_search(params)
      API::CandidateSearches.new(@api_key, @url).create(params)
    end

  end

end
