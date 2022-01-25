
module Entities
  class Patient < Grape::Entity
    expose :id
    expose :address
    expose :allergies_additional
    expose :date_of_birth
    expose :email
    expose :full_name
    expose :notes
    expose :telephone_number
    expose :passport_id
    #expose :allergies
    #expose :picture
  end
end
