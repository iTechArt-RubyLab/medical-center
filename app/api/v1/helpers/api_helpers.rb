module V1
  module Helpers
    module APIHelpers
      def host
        Rails.env.production? ? 'morning-plains-26206.herokuapp.com' : 'http://localhost:3000'
      end
    end
  end
end
