class User < ApplicationRecord
  include UserStatus

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_one_attached :avatar

  enum role: { common: 0, admin: 1 }

  validates :full_name, presence: true, length: { in: 3..50 }
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true
  validates_with PhoneNumberValidator
  validates_date :birthdate, presence: true, between: ['01.01.1900', :today]
  validates :role, presence: true
  validates :cabinet_number, presence: true
  validates :status, presence: true
end
