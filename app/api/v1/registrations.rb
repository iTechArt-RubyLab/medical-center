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
        service_answer = Endpoints::Registrations::Post.new(params: params).call

        if service_answer.success?
          service_answer.result
        else
          error!(service_answer.errors.full_messages.to_sentence)
        end
      end
    end
  end
end
