class Patient < ApplicationRecord
  has_many :patient_allergies, dependent: :destroy
  has_many :allergies, through: :patient_allergies

  validates :full_name, presence: true, length: { in: 3..50 }
  validates :email, email: true, allow_blank: true, uniqueness: true
  validates :telephone_number, presence: true, length: { in: 7..12 }, numericality: { only_integer: true }
  validates_date :date_of_birth, presence: true, between: ['01.01.1900', :today]
  validates :passport_id, presence: true, length: { in: 6..50 }, uniqueness: true
  validates :address, presence: true
end
