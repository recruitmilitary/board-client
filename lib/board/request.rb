module Board
  module Request

    class Error < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
      end
    end

    private

    def post(path, params)
      request path, params, :post
    end

    def get(path, params)
      request path, params, :get
    end

    def request(path, params, method)
      params.merge!(:user_credentials => @api_key)

      response = case method
                 when :get
                   uri = URI.parse(@url + path + "?" + hash_to_query_string(params))
                   Net::HTTP.get_response(uri)
                 when :post
                   uri = URI.parse(@url + path)
                   Net::HTTP.post_form(uri, params)
                 end

      if response.code =~ /2../
        Yajl::Parser.parse(response.body)
      else
        raise Error.new(response)
      end
    end

    def hash_to_query_string(hash)
      params = ''
      stack = []

      hash.each do |k, v|
        if v.is_a?(Hash)
          stack << [k,v]
        else
          params << "#{k}=#{v}&"
        end
      end

      stack.each do |parent, hash|
        hash.each do |k, v|
          if v.is_a?(Hash)
            stack << ["#{parent}[#{k}]", v]
          else
            params << "#{parent}[#{k}]=#{v}&"
          end
        end
      end

      params.chop! # trailing &
      params
    end

  end
end
