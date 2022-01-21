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
#  doctor_id   :integer          not null
#  patient_id  :integer          not null
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
