# == Schema Information
#
# Table name: visits
#
#  id            :bigint           not null, primary key
#  birthday      :datetime         not null
#  cabinet       :string           not null
#  date          :datetime         not null
#  notes         :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  doctor_id     :integer          not null
#  patient_id    :integer          not null
#  sick_leave_id :bigint           not null
#
# Indexes
#
#  index_visits_on_sick_leave_id  (sick_leave_id)
#
# Foreign Keys
#
#  fk_rails_...  (sick_leave_id => sick_leaves.id)
#
class Visit < ApplicationRecord
  has_many :visits_diagnoses, dependent: :destroy
  has_many :diagnoses, through: :visits_diagnoses
end
