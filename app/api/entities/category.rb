module Entities
  class Category < Grape::Entity
    expose :id
    expose :title
    expose :description
  end
end
