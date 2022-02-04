# == Schema Information
#
# Table name: visits
#
#  id            :bigint           not null, primary key
#  cabinet       :string           not null
#  date          :datetime         not null
#  notes         :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  patient_id    :bigint           not null
#  sick_leave_id :bigint
#  user_id       :bigint           not null
#  visit_id      :bigint
#
# Indexes
#
#  index_visits_on_patient_id     (patient_id)
#  index_visits_on_sick_leave_id  (sick_leave_id)
#  index_visits_on_user_id        (user_id)
#  index_visits_on_visit_id       (visit_id)
#
# Foreign Keys
#
#  fk_rails_...  (patient_id => patients.id)
#  fk_rails_...  (sick_leave_id => sick_leaves.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (visit_id => visits.id)
#
class Visit < ApplicationRecord
  belongs_to :patient
  belongs_to :user
  belongs_to :sick_leave
  belongs_to :next_visit, class_name: 'Visit', foreign_key: 'visit_id', inverse_of: :visits
  has_many :visits_diagnoses, dependent: :destroy
  has_many :diagnoses, through: :visits_diagnoses

  validates :cabinet, presence: true, length: { in: 1..10 }
  validates :date, presence: true
end
