module Board
  class Client::API

    def initialize(client)
      @client = client
    end

    def post(path, attributes = {})
      Hashie::Mash.new(@client.post(path, attributes))
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
