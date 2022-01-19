FactoryBot.define do
  factory :sick_leave do
    destination { Faker::Company.name }
    doctor_id {  } # I do not have these models as they are made by other developers
    patient_id {  } # I do not have these models as they are made by other developers
    started_at { 5.days.from_now }
    ended_at { 10.days.from_now }
  end
end
