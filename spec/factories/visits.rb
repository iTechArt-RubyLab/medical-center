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
