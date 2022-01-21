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
  factory :visit do
    cabinet { Faker::Number.number(digits: 3) }
    # doctor_id {  } I do not have these models as they are made by other developers
    # patient_id {  } I do not have these models as they are made by other developers
    date { 10.days.from_now }
    # birthday {  } I do not have these models as they are made by other developers
    notes { Faker::Lorem.sentence(word_count: rand(2..10)) }
    sick_leave_id { create(:sick_leave).id }
  end
end
