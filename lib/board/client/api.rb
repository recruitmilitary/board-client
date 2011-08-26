module Board
  class Client::API

    def initialize(client)
      @client = client
    end

    def post(path, attributes = {})
      Hashie::Mash.new(@client.post(path, attributes))
    end

    def get(path, attributes = {})
      Hashie::Mash.new(@client.get(path, attributes))
    end

  end
 end
