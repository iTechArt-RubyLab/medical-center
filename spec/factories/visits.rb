FactoryBot.define do
  factory :visit do
    cabinet { Faker::Number.number(digits: 3) }
    doctor_id {  } # I do not have these models as they are made by other developers
    patient_id {  } # I do not have these models as they are made by other developers
    date { 10.days.from_now }
    birthday {  } # I do not have these models as they are made by other developers
    notes { Faker::Lorem.sentence(word_count: rand(2..10)) }
    sick_leave_id { create(:sick_leave).id }
  end
end
