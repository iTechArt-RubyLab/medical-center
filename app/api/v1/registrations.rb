module V1
  class Registrations < API
    version 'v1', using: :path
    format :json
    prefix :api
    resource :registrations do
      desc 'Authenticate user and return user object / access token'

      params do
        requires :email, type: String, desc: 'Users email'
        requires :password, type: String, desc: 'Users password'
        requires :cabinet_number, type: String, desc: 'Users cabinet number'
        requires :birthdate, type: Date, desc: 'Users birthdate'
        requires :phone_number, type: String, desc: 'Users phone number'
        requires :full_name, type: String, desc: 'Users full name'
        requires :password_confirmation, type: String, desc: 'User password confirmation'
      end

      post do
        email = params[:email]
        password = params[:password]

        error!({ error_code: 404, error_message: 'Invalid Email or Password.' }, 401) if email.nil? || password.nil?

        user = User.create(params)
        user.ensure_authentication_token
        UserMailer.with(user: user, host: host).registration_confirmation.deliver
        { status: 'ok', auth_token: user.authentication_token } if user
      end
    end
  end
end
