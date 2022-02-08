# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  authentication_token   :string(30)
#  birthdate              :date             not null
#  cabinet_number         :string           not null
#  confirm_token          :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  email_confirmed        :boolean          default(FALSE)
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
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_phone_number          (phone_number) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_status                (status)
#
class User < ApplicationRecord
  include UserStatus

  before_create :confirmation_token

  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories

  has_many :user_sick_leave, dependent: :destroy
  has_many :sick_leaves, through: :user_sick_leave

  has_many :visits, dependent: :nullify
  has_many :sick_leaves, dependent: :nullify

  has_one_attached :avatar

  enum role: { common: 0, admin: 1 }

  validates :full_name, presence: true, length: { in: 3..50 }
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true, length: { is: 7 }, numericality: { only_integer: true }
  validates_date :birthdate, presence: true, between: ['01.01.1900', :today]
  validates :role, presence: true
  validates :cabinet_number, presence: true
  validates :status, presence: true

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!
  end
end
