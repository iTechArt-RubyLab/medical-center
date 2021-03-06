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
#
FactoryBot.define do
  factory :sick_leave do
    destination { Faker::Company.name }
    started_at { 5.days.from_now }
    ended_at { 10.days.from_now }
  end
end
