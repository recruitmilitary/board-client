require 'uri'
require 'net/http'
require 'net/https'

module Board
  module Request

    class Error < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
      end
    end

    NotFound = Class.new(Error)

    def post(path, params)
      request path, params, :post
    end

    def get(path, params = {})
      request path, params, :get
    end

    def request(path, params, method)
      params.merge!(:user_credentials => @api_key)

      uri = URI.parse(@url + path)
      http = Net::HTTP.new(uri.host, uri.port)

      if uri.port == 443 # ssl?
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end

      case method
      when :get
        request = Net::HTTP::Get.new(uri.request_uri)
      when :post
        request = Net::HTTP::Post.new(uri.request_uri)
      end

      request.set_form_data(params)
      response = http.request(request)

      if response.code =~ /2../
        Yajl::Parser.parse(response.body)
      elsif response.code == '404'
        raise NotFound.new(response)
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
