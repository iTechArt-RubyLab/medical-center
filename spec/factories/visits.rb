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
  factory :visit do
    cabinet { Faker::Number.number(digits: 3) }
    user { sick_leave.user }
    patient { sick_leave.patient }
    date { 10.days.from_now }
    notes { Faker::Lorem.sentence(word_count: rand(2..10)) }
    sick_leave { create(:sick_leave) }
  end
end
