module Board
  module API

    class Base

      def initialize(api_key, base_url)
        @api_key  = api_key
        @base_url = base_url
      end

      private

      def get(*args)
        request(:get, *args)
      end

      def post(*args)
        request(:post, *args)
      end

      def request(http_method, *args)
        path   = args.shift
        params = args.shift.merge(:user_credentials => @api_key)
        url    = @base_url + path

        response = case http_method
        when :get
          RestClient.get(url, { :params => params, :accept => :json })
        when :post
          RestClient.post(url, encode_json(params), :content_type => :json, :accept => :json)
        else
          raise ArgumentError, "unknown http method: #{http_method}"
        end

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
