module V1
  class Users < API
    resources :users do
      desc 'Return all users'
      get do
        @users = User.all
        present @users, with: Entities::User
      end

      desc 'Return specific user'
      route_param :id, type: Integer do
        get do
          user = User.find(params[:id])
          { user: user }
        end
      end
      desc 'create a new song'
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post do
        User.create!({ email: params[:email], password: params[:password] })
      end
    end
  end
end
