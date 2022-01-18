class Diagnosis < ApplicationRecord
  has_many :visits_diagnoses
  has_many :visits, through: :visits_diagnoses
end