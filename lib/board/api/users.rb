module Board
  module API

    class Users < Base

      def find(params)
        get @url + "/users", params
      end

    end

  end
end
