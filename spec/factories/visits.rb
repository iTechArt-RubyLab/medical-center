FactoryBot.define do
  sick_leave = FactoryBot.create(:sick_leave)
  user = sick_leave.doctor_id
  patient = Patient.find_by(id: sick_leave.patient_id)

  factory :visit do
    cabinet { Faker::Number.number(digits: 3) }
    doctor_id { user }
    patient_id { patient.id }
    date { 10.days.from_now }
    birthday { patient.date_of_birth }
    notes { Faker::Lorem.sentence(word_count: rand(2..10)) }
    sick_leave_id { sick_leave.id }
  end
end
