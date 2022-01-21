FactoryBot.define do
  factory :user_sick_leave do
    association :user
    association :sick_leave
  end
end
