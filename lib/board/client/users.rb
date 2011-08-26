module Board
  class Client::Users

    def initialize(client)
      @client = client
    end

    def create(attributes)
      Hashie::Mash.new(@client.post("/users", attributes))
    end

    def find(id)
      if id.is_a?(Hash)
        Hashie::Mash.new(@client.get("/users", id))
      else
        Hashie::Mash.new(@client.get("/users/#{id}"))
      end
    end

    def unsubscribe(email)
      Hashie::Mash.new(@client.get("/users/unsubscribe", :email => email))
    end

  end
end
