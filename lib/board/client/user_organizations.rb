module Board
  class Client::UserOrganizations < Client::API

    def list(attributes)
      user_id = attributes.fetch(:user_id) {
        raise ArgumentError, "user_id is required"
      }

      get("/users/#{user_id}/organizations")
    end

  end
end
