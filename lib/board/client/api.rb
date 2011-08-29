module Board
  class Client::API

    def initialize(client)
      @client = client
    end

    def post(path, attributes = {})
      json = @client.post(path, attributes)

      if json.is_a?(Hash)
        Hashie::Mash.new(json)
      else
        json
      end
    end

    def get(path, attributes = {})
      json = @client.get(path, attributes)

      if json.is_a?(Array)
        json.map { |item| Hashie::Mash.new(item) }
      else
        Hashie::Mash.new(json)
      end
    end

  end
end
