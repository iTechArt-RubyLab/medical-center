FactoryBot.define do
  factory :category do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(word_count: 5) }
  end
end
