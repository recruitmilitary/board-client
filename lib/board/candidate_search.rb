module Board

  class CandidateSearch

    attr_reader :errors

    def initialize(client, params = {})
      @client = client
      @params = params
      @errors = []
    end

    def results
      initial_search['results']
    end

    def each_result
      total = initial_search['total']
      pages = (total / 10.0).ceil

      initial_search['results'].each { |r| yield r }

      (2..pages).each do |page|
        search = @client.candidate_searches(@params.merge(:page => page))
        results = search['results']
        results.each { |r| yield r }
      end
    end

    def valid?
      perform_search and @errors.empty?
    end

    private

    def initial_search
      @initial_search ||= @client.candidate_searches(@params)
    rescue Board::Request::Error => e
      @errors = Yajl::Parser.parse(e.response.body)
    end
    alias perform_search initial_search

  end

end
