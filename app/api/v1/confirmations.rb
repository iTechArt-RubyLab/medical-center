module V1
  class Confirmations < API
    version 'v1', using: :path
    format :json
    prefix :api
    resource :confirmations do
      desc 'Confirm user registration'

      params do
        requires :confirm_token, type: String, desc: 'User confirm token'
      end

      post do
        user = User.find_by(confirm_token: params[:confirm_token])
        user&.email_activate
      end
    end
  end
end
