class Category < ApplicationRecord
  has_many :users, through: :user_categories
end
