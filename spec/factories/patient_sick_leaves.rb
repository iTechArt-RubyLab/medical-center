FactoryBot.define do
  factory :patient_sick_leave do
    association :patient
    association :sick_leave
  end
end
