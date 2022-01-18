class User < ApplicationRecord
  include UserStatus

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, through: :user_categories
  has_one_attached :avatar

  enum role: { common: 0, admin: 1 }
end
