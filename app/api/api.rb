class API < Grape::API
  format :json
  prefix :api
  version 'v1', :path

  # before do
  #   authenticate!
  # end

  helpers do
    def current_user
      user = User.find_by(authentication_token: request.headers['Authorization'])
      if user
        @current_user = user
      else
        false
      end
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end
  end

  mount V1::Sessions
  mount V1::Users
  mount V1::Registrations
end
