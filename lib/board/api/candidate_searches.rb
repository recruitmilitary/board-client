module Board::API

  class CandidateSearches < Base
    
    def create(params)
      Board::CandidateSearch.new(@api_key, @url, params)
    end

  end

end
