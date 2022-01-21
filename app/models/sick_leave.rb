class SickLeave < ApplicationRecord
  has_many :patient_sick_leave, dependent: :destroy
  has_many :patient, through: :patient_sick_leave

  has_many :user_sick_leave, dependent: :destroy
  has_many :users, through: :user_sick_leave

  has_many :visits, dependent: :nullify
end
