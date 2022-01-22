# == Schema Information
#
# Table name: patient_allergies
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  allergy_id :bigint           not null
#  patient_id :bigint           not null
#
# Indexes
#
#  index_patient_allergies_on_allergy_id  (allergy_id)
#  index_patient_allergies_on_patient_id  (patient_id)
#
# Foreign Keys
#
#  fk_rails_...  (allergy_id => allergies.id)
#  fk_rails_...  (patient_id => patients.id)
#
class PatientAllergy < ApplicationRecord
  belongs_to :patient
  belongs_to :allergy
end
