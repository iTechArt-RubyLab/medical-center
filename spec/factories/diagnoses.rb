FactoryBot.define do
  factory :diagnosis do
    name { Faker::Lorem.word }
    symptom { Faker::Lorem.sentence(word_count: rand(2..10)) }
    medication_list { Faker::Lorem.sentence(word_count: rand(2..10)) }

    trait :tuberculosis do
      name { 'Tuberculosis' }
      symptom { 'Coughing up blood' }
      medication_list { 'Hematogen' }
    end

    trait :bronchitis do
      name { 'Bronchitis' }
      symptom { 'Dyspnea' }
      medication_list { 'Paracetamol' }
    end

    trait :tonsillitis do
      name { 'Tonsillitis' }
      symptom { 'Sore throat' }
      medication_list { 'Vitamin C' }
    end
  end
end
