require 'rubygems'
require 'bundler/setup'

require 'rest_client'
require 'yajl'

require 'board/api'

module Board

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

  end

end
