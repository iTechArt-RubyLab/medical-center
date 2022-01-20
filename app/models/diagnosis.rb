class Diagnosis < ApplicationRecord
  has_many :visits_diagnoses, dependent: :destroy
  has_many :visits, through: :visits_diagnoses
end
