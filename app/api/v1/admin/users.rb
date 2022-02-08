module V1
  module Admin
    class Users < API
      helpers Helpers::CrudHelpers

      resources :users do
        desc 'Return all users'
        params do
          optional :sort, type: Hash
        end
        get do
          default_sort = { column_name: 'full_name', type: 'asc' }
          present sorting(User, declared(params)[:sort], default_sort).paginate(page: params[:page]), with: Entities::User
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
