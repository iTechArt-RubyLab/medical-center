class API < Grape::API
  format :json
  prefix :api
  version 'v1', :path

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
  mount V1::Confirmations
  mount V1::SickLeaves
  namespace :admin do
    mount V1::Admin::SickLeaves
  end
end
