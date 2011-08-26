module Board
  class Client::Candidates < Client::API

    def find(id)
      get("/candidates/#{id}")
    end

    def invite(attributes)
      post("/candidate_invitations", attributes)
    end

  end
end
