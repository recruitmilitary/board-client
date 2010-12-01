module Board::API

  class CandidateSearches < Base

    def create(params)
      get @url + "/candidate_searches", params
    end

  end

end
