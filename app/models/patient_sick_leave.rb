# == Schema Information
#
# Table name: patient_sick_leaves
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  patient_id    :bigint           not null
#  sick_leave_id :bigint           not null
#
# Indexes
#
#  index_patient_sick_leaves_on_patient_id     (patient_id)
#  index_patient_sick_leaves_on_sick_leave_id  (sick_leave_id)
#
# Foreign Keys
#
#  fk_rails_...  (patient_id => patients.id)
#  fk_rails_...  (sick_leave_id => sick_leaves.id)
#
class PatientSickLeave < ApplicationRecord
  belongs_to :patient
  belongs_to :sick_leave
end
