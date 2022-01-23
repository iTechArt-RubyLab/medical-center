# == Schema Information
#
# Table name: sick_leaves
#
#  id          :bigint           not null, primary key
#  destination :string
#  ended_at    :datetime         not null
#  started_at  :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  patient_id  :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_sick_leaves_on_patient_id  (patient_id)
#  index_sick_leaves_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (patient_id => patients.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :sick_leave do
    destination { Faker::Company.name }
    # doctor_id {  } I do not have these models as they are made by other developers
    # patient_id {  } I do not have these models as they are made by other developers
    started_at { 5.days.from_now }
    ended_at { 10.days.from_now }
  end
end
