FactoryBot.define do
  factory :patient do
    full_name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    telephone_number { Faker::Number.unique.number(digits: 7) }
    date_of_birth { Faker::Date.between(from: '1900-01-01', to: Time.zone.today) }
    passport_id { Faker::Alphanumeric.unique.alpha(number: rand(6..50)) }
    address { Faker::Address.full_address }
  end
end
