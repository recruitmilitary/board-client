module Board::API

  class CandidateSearches < Base

    def create(params)
      Board::CandidateSearch.new(@api_key, @base_url, params)
    end

  end

end
