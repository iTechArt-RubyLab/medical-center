module V1
  module Admin
    class Users < API
      resources :users do
        desc 'Return all users'
        get do
          users = User.all
          present users, with: Entities::User
        end

        desc 'Return specific user'
        route_param :id, type: Integer do
          get do
            present User.find(params[:id]), with: Entities::User
          end
        end
      end
    end
  end
end
