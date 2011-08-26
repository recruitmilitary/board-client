module Board
  class Client::Users < Client::API

    def create(attributes)
      post("/users", attributes)
    end

    def find(id)
      if id.is_a?(Hash)
        get("/users", id)
      else
        get("/users/#{id}")
      end
    end

    def unsubscribe(email)
      get("/users/unsubscribe", :email => email)
    end

  end
end
