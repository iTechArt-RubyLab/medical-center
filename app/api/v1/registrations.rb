module V1
  class Registrations < API
    version 'v1', using: :path
    format :json
    prefix :api

    resource :registrations do
      desc 'Authenticate user and return user object / access token'

      params do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User Password'
        requires :cabinet_number, type: String, desc: 'User Password'
        requires :birthdate, type: Date, desc: 'User Password'
        requires :phone_number, type: String, desc: 'User Password'
        requires :full_name, type: String, desc: 'User Password'
      end

      post do
        email = params[:email]
        password = params[:password]
        params[:cabinet_number]
        params[:birthdate]
        params[:full_name]
        params[:phone_number]

        if email.nil? || password.nil?
          error!({ error_code: 404, error_message: 'Invalid Email or Password.' }, 401)
          return
        end

        user = User.create(params)
        if user.nil?
          error!({ error_code: 404, error_message: 'Invalid Email or Password.' }, 401)
          return
        end

        if user.valid_password?(password)
          user.ensure_authentication_token
          user.save
          { status: 'ok', auth_token: user.authentication_token }
        else
          error!({ error_code: 404, error_message: 'Invalid Email or Password.' }, 401)
          return
        end
      end

      desc 'Destroy the access token'
      params do
        requires :auth_token, type: String, desc: 'User Access Token'
      end
      delete ':auth_token' do
        auth_token = params[:auth_token]
        user = User.find_by(authentication_token: auth_token)
        if user.nil?
          error!({ error_code: 404, error_message: 'Invalid access token.' }, 401)
          return
        else
          user.reset_authentication_token
          { status: 'ok' }
        end
      end
    end
  end
end
