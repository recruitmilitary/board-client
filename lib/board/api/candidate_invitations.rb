module Board::API

  class CandidateInvitations < Base

    def create(params)
      post @url + "/candidate_invitations", params
    end

  end

end
