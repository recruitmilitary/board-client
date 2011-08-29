module Board
  class Client::UserOrganizations < Client::API

    def list(attributes)
      user_id = attributes.fetch(:user_id) {
        raise ArgumentError, "user_id is required"
      }

      get("/users/#{user_id}/organizations")
    end

    def create(attributes)
      user_id = attributes.fetch(:user_id)
      organization_id = attributes.fetch(:organization_id)

      post("/users/#{user_id}/organizations", :id => organization_id)
    end

  end
end
