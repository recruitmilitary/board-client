module Board
  class Client::Candidates

    def initialize(client)
      @client = client
    end

    def find(id)
      Hashie::Mash.new(@client.get("/candidates/#{id}"))
    end

  end
end
