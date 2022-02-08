module V1
  module Admin
    class Users < API
      resources :users do
        desc 'Return all users'
        params do
          optional :sort, type: Hash
        end
        get do
          present sorting(User, declared(params)[:sort]).paginate(page: params[:page]), with: Entities::User
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
