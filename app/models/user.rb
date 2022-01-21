# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birthdate              :date             not null
#  cabinet_number         :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string           not null
#  phone_number           :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("common"), not null
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_phone_number          (phone_number) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_status                (status)
#
class User < ApplicationRecord
  include UserStatus

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :visits, dependent: :nullify
  has_many :sick_leaves, dependent: :nullify
  
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
