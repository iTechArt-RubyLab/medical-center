module Entities
  class Patient < Grape::Entity
    expose :id
    expose :address
    expose :date_of_birth
    expose :email
    expose :full_name
    expose :notes
    expose :telephone_number
    expose :passport_id
    expose :allergies do
      expose :allergies, using: API::Entities::Allergy
      expose :allergies_additional
    end
  end
end
