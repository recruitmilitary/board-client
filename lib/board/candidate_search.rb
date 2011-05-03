module Board

  class CandidateSearch

    def initialize(client, params = {})
      @client = client
      @params = params
    end

    def results
      @client.candidate_searches(@params)['results']
    end

    def each_result
      initial_search = @client.candidate_searches(@params)
      total = initial_search['total']
      pages = (total / 10.0).ceil

      initial_search['results'].each { |r| yield r }

      (2..pages).each do |page|
        search = @client.candidate_searches(@params.merge(:page => page))
        results = search['results']
        results.each { |r| yield r }
      end
    end

  end

end
