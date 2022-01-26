module V1
  class Sessions < API
    version 'v1', using: :path
    format :json
    prefix :api
    # rubocop:disable Metrics/BlockLength
    resource :sessions do
      desc 'Authenticate user and return user object / access token'

      params do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User Password'
      end

      post do
        service_answer = Endpoints::Sessions::Post.new(params: params).call

        if service_answer.success?
          service_answer.result
        else
          error!(service_answer.errors.full_messages.to_sentence)
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
        else
          user.reset_authentication_token
          { status: 'ok' }
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
