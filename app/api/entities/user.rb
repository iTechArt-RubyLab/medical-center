module Entities
  class User < Grape::Entity
    expose :id
    expose :email
    expose :full_name
    expose :role
    expose :phone_number
    expose :birthdate
    expose :cabinet_number
    expose :status
    unexpose :authentication_token
  end
end
