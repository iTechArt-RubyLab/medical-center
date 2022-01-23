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
#  sick_leave_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_visits_on_patient_id     (patient_id)
#  index_visits_on_sick_leave_id  (sick_leave_id)
#  index_visits_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (patient_id => patients.id)
#  fk_rails_...  (sick_leave_id => sick_leaves.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  sick_leave = FactoryBot.create(:sick_leave)
  user = sick_leave.doctor_id
  patient = Patient.find_by(id: sick_leave.patient_id)

  factory :visit do
    cabinet { Faker::Number.number(digits: 3) }
    doctor_id { user }
    patient_id { patient.id }
    date { 10.days.from_now }
    birthday { patient.date_of_birth }
    notes { Faker::Lorem.sentence(word_count: rand(2..10)) }
    sick_leave_id { sick_leave.id }
  end
end
