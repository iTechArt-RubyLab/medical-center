# == Schema Information
#
# Table name: patients
#
#  id                   :bigint           not null, primary key
#  address              :string
#  allergies_additional :text
#  date_of_birth        :datetime
#  email                :string
#  full_name            :string           not null
#  notes                :text
#  telephone_number     :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  passport_id          :string
#
# Indexes
#
#  index_patients_on_email        (email) UNIQUE
#  index_patients_on_passport_id  (passport_id) UNIQUE
#
class Patient < ApplicationRecord
  has_many :patient_allergies, dependent: :destroy
  has_many :allergies, through: :patient_allergies

  has_one_attached :avatar

  validates :full_name, presence: true, length: { in: 3..50 }
  validates :email, email: true, allow_blank: true, uniqueness: true
  validates :telephone_number, presence: true, length: { in: 7..12 }, numericality: { only_integer: true }
  validates_date :date_of_birth, presence: true, between: ['01.01.1900', :today]
  validates :passport_id, presence: true, length: { in: 6..50 }, uniqueness: true
  validates :address, presence: true
end
