module Board
  class Client::Users

    def initialize(client)
      @client = client
    end

    def create(attributes)
      Hashie::Mash.new(@client.post("/users", attributes))
    end

  end
end
