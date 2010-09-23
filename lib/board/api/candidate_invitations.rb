module Board::API

  class CandidateInvitations

    def initialize(api_key, url)
      @api_key = api_key
      @url     = url
    end

    def create(params)
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
