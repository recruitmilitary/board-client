module Board::API

  class CandidateInvitations < Base

    def create(params)
      post "/candidate_invitations", params
    end

  end

end
