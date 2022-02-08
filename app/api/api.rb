class API < Grape::API
  format :json
  prefix :api
  version 'v1', :path
  
  NON_AUTHENTICATION_PATHS = [
    '/api/v1/sessions',
    '/api/v1/registrations'
  ].freeze

  before do
    authenticate! unless NON_AUTHENTICATION_PATHS.include? request.env['REQUEST_PATH']
  end

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
  end
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :params_missing
  rescue_from ActiveModel::ValidationError, with: :validation_error
  rescue_from ArgumentError, with: :argument_error

  helpers ::Helpers::ErrorHandlerHelpers

  mount V1::Sessions
  mount V1::Registrations
  mount V1::Confirmations
  mount V1::SickLeaves
  mount V1::Visits
  mount V1::Diagnoses
  namespace :admin do
    mount V1::Admin::Users
    mount V1::Admin::Visits
    mount V1::Admin::Diagnoses
    mount V1::Admin::SickLeaves
    mount V1::Admin::Patients
    mount V1::Admin::Categories
  end
end
