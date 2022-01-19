class Allergy < ApplicationRecord
  has_many :patient_allergies, dependent: :destroy
  has_many :patients, through: :patient_allergies
end
