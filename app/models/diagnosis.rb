# == Schema Information
#
# Table name: diagnoses
#
#  id              :bigint           not null, primary key
#  medication_list :text             not null
#  name            :string           not null
#  symptom         :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_diagnoses_on_name  (name) UNIQUE
#
class Diagnosis < ApplicationRecord
  has_many :visits_diagnoses, dependent: :destroy
  has_many :visits, through: :visits_diagnoses
end
