module Board
  module API

    class Base

      def initialize(api_key, url)
        @api_key = api_key
        @url     = url
      end

      private

      def get(*args)
        url = args.shift
        params = args.shift.merge(:user_credentials => @api_key)

        response = RestClient.get(url, { :params => params, :accept => :json })
        decode_json(response.body)
      end

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
end
