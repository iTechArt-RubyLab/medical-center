FactoryBot.define do
  factory :sick_leave do
    destination { Faker::Company.name }
    doctor_id { create(:user).id }
    patient_id { create(:patient).id }
    started_at { 5.days.from_now }
    ended_at { 10.days.from_now }
  end
end
