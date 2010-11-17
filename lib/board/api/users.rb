module Board
  module API

    class Users < Base

      def find(params)
        get @url + "/users", params
      end

      def unsubscribe(params)
        get @url + "/users/unsubscribe", params
      end
    end

  end
end
