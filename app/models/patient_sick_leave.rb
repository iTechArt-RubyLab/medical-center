class PatientSickLeave < ApplicationRecord
  belongs_to :patient
  belongs_to :sick_leave
end
