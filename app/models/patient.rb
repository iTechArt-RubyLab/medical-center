class Patient < ApplicationRecord
  has_many :patient_allergies, dependent: :destroy
  has_many :allergies, through: :patient_allergies
end
