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
        error!({ error_message: 'You provided invalid token' }, 422)
      end
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end

    def user_are_admin?
      error!('401 Unauthorized: permission denied', 401) unless current_user.role == 'admin'
    end
  end

  before do
    authenticate!
  end

  mount V1::Sessions
  mount V1::Registrations
  mount V1::Confirmations
  mount V1::SickLeaves
  mount V1::Visits
  mount V1::Diagnoses

  namespace :admin do
    before do
      user_are_admin?
    end

    mount V1::Admin::Users
    mount V1::Admin::Visits
    mount V1::Admin::Diagnoses
    mount V1::Admin::SickLeaves
    mount V1::Admin::Patients
    mount V1::Admin::Allergies
    mount V1::Admin::Categories
  end
end
