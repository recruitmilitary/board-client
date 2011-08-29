module Board
  class Client::Organizations < Client::API

    def create(attributes)
      post("/organizations", attributes)
    end

    def find(id)
      if id.is_a?(Hash)
        get("/organizations", id)
      else
        get("/organizations/#{id}")
      end
    end

  end
end
