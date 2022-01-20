FactoryBot.define do
  factory :patient do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    telephone_number { Faker::PhoneNumber.subscriber_number(length: rand(7..12)) }
    date_of_birth { Faker::Date.between(from: '1900-01-01', to: Time.zone.today) }
    passport_id { Faker::Alphanumeric.alpha(number: rand(6..50)) }
    address { Faker::Address.full_address }
  end
end
