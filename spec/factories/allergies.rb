FactoryBot.define do
  factory :allergy do
    name { Faker::Cannabis.cannabinoid }
  end
end
