class PhoneNumberValidator < ActiveModel::Validator
  def validate(record)
    return if Phonelib.valid? record.telephone_number
    
    record.errors.add :telephone_number, 'Invalid telephone number'
  end
end

class Patient < ApplicationRecord
  has_many :patient_allergies, dependent: :destroy
  has_many :allergies, through: :patient_allergies

  validates :full_name, presence: true, length: { in: 3..50 }
  validates :email, email: true, allow_blank: true
  validates_with PhoneNumberValidator
  validates_date :date_of_birth, presence: true, between: ['01.01.1900', :today]
  validates :passport_id, presence: true, length: { in: 6..50 }
  validates :address, presence: true
end
