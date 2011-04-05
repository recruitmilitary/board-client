module Board
  module API

    class Users < Base

      def find(params)
        get "/users", params
      end

      def unsubscribe(params)
        get "/users/unsubscribe", params
      end

      def invalid(params)
        get "/users/invalid", params
      end

    end

  end
end
