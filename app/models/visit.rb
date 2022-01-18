class Visit < ApplicationRecord
  has_many :visits_diagnoses
  has_many :diagnoses, through: :visits_diagnoses
end
