module Grapes
  module V1
    class Users < Grapes::API
      resources :users do
        desc 'Return all users'
        get do
          ::User.all
        end
      end
    end
  end
end
