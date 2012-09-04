require 'uri'
require 'net/http'
require 'net/https'
require 'certified'

module Board
  module Client::Request

    def post(path, params)
      request path, params, :post
    end

    def get(path, params = {})
      request path, params, :get
    end

    def request(path, params, method)
      params.merge!(:user_credentials => @api_key)

      uri = URI.parse(@endpoint + path)
      http = Net::HTTP.new(uri.host, uri.port)

      if uri.port == 443 # ssl?
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http.ca_path = @ssl[:ca_path] if @ssl[:ca_path]
      end

      case method
      when :get
        request = Net::HTTP::Get.new(uri.request_uri)
      when :post
        request = Net::HTTP::Post.new(uri.request_uri)
      end

      request.set_form_data(params)
      response = http.request(request)

      case response.code
      when /2../
        if response.body.empty?
          true
        else
          Yajl::Parser.parse(response.body)
        end
      when '400'
        raise Client::BadRequest.new(response)
      when '401'
        raise Client::Unauthorized.new(response)
      when '403'
        raise Client::Forbidden.new(response)
      when '404'
        raise Client::NotFound.new(response)
      when '406'
        raise Client::NotAcceptable.new(response)
      when '409'
        raise Client::Conflict.new(response)
      when '422'
        raise Client::UnprocessableEntity.new(response)
      when '500'
        raise Client::InternalServerError.new(response)
      when '501'
        raise Client::NotImplemented.new(response)
      when '502'
        raise Client::BadGateway.new(response)
      when '503'
        raise Client::ServiceUnavailable.new(response)
      else
        raise Client::Error.new(response)
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
