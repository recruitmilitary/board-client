module Board

  class CandidateSearch < API::Base

    DEFAULT_PER_PAGE = 10

    attr_reader :params

    def initialize(*args)
      @params = args.pop
      self.current_page = params[:current_page] || 1
      super
    end

    def each_result
      (current_page..total_pages).each do |page|
        self.current_page = page
        results.each do |result|
          yield result
        end
        clear
      end
    end

    def total_pages
      (total / per_page.to_f).ceil
    end

    def per_page
      params[:per_page] || DEFAULT_PER_PAGE
    end

    def results
      response['results']
    end

    def total
      response['total']
    end

    def current_page
      params[:current_page]
    end

    def current_page=(value)
      params[:current_page] = value
    end

    private

    def clear
      @response = nil
    end

    def response
      @response ||= get "/candidate_searches", params
    end

  end

end
