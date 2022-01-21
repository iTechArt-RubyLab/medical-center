FactoryBot.define do
  factory :category do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(word_count: 5) }

    trait :dentist do
      title { 'Dentist' }
      description { 'Dental treatment' }
    end

    trait :ophthalmologist do
      title { 'Ophthalmologist' }
      description { 'Vision treatment' }
    end

    trait :pediatrician do
      title { 'Pediatrician' }
      description { 'Treatment of common diseases' }
    end
  end
end
