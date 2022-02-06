module V1
  class Sessions < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api
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
    end
  end
end
