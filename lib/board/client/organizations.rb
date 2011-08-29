module Board
  class Client::Organizations < Client::API

    def create(attributes)
      post("/organizations", attributes)
    end

  end
end
