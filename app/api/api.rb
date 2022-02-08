class API < Grape::API
  helpers ::Helpers::APIHelpers

  format :json
  prefix :api
  version 'v1', :path

  before do
    authenticate! if call_authentication?
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

    def call_authentication?
      true
    end

    def authorize_admin!
      error!('401 Unauthorized: permission denied', 401) unless admin?
    end

    def admin?
      current_user.role == 'admin'
    end

    def sorting(class_name, sort_by)
      if sort_by[:column_name] && sort_by[:type]
        class_name.order("#{sort_by[:column_name]} #{sort_by[:type]}")
      else
        class_name.order(id: :asc)
      end
    end
  end
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :params_missing
  rescue_from ActiveModel::ValidationError, with: :validation_error
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ArgumentError, with: :argument_error

  helpers ::Helpers::ErrorHandlerHelpers

  mount V1::Sessions
  mount V1::Registrations
  mount V1::Confirmations
  mount V1::Allergies
  mount V1::Categories
  mount V1::Diagnoses
  mount V1::Patients
  mount V1::SickLeaves
  mount V1::Visits
  namespace :admin do
    before do
      authorize_admin!
    end

    mount V1::Admin::Users
    mount V1::Admin::Allergies
    mount V1::Admin::Categories
    mount V1::Admin::Diagnoses
    mount V1::Admin::Categories
    mount V1::Admin::SickLeaves
    mount V1::Admin::Patients
    mount V1::Admin::Exports
    mount V1::Admin::Visits
  end
end
