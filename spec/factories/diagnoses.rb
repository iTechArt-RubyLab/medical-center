FactoryBot.define do
  factory :diagnosis do
    name { Faker::Lorem.word }
    symptom { Faker::Lorem.sentence(word_count: rand(2..10)) }
    medication_list { Faker::Lorem.sentence(word_count: rand(2..10)) }
  end
end
