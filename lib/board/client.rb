require 'rubygems'
require 'bundler/setup'

require 'rest_client'
require 'yajl'

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

    def create_candidate_invitation(params)
      post @url + "/candidate_invitations", params
    end

    private

    def post(*args)
      url = args.shift
      params = args.shift.merge(:user_credentials => @api_key)

      response = RestClient.post(url, encode_json(params), :content_type => :json, :accept => :json)
      decode_json(response.body)
    end

    def encode_json(obj)
      Yajl::Encoder.encode(obj)
    end

    def decode_json(json)
      Yajl::Parser.parse(json)
    end

  end

end
