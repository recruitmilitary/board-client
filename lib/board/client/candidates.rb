module Board
  class Client::Candidates

    def initialize(client)
      @client = client
    end

    def find(id)
      Hashie::Mash.new(@client.get("/candidates/#{id}"))
    end

    def invite(attributes)
      Hashie::Mash.new(@client.post("/candidate_invitations", attributes))
    end

  end
end
