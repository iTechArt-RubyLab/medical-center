FactoryBot.define do
  factory :allergy do
    name { Faker::Cannabis.cannabinoid }

    trait :sweets do
      name { 'Allergy to sweets' }
    end

    trait :citrus do
      name { 'Allergy to citrus' }
    end

    trait :pollen do
      name { 'Pollen allergy' }
    end
  end
end
