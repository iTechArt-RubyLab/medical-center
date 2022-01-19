class Visit < ApplicationRecord
  has_many :visits_diagnoses, dependent: :destroy
  has_many :diagnoses, through: :visits_diagnoses
end
