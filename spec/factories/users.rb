FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    role { 'common' }
    phone_number { "+375(29)#{Faker::Number.number(digits: 7)}" }
    email { Faker::Internet.email }
    status { 'working' }
    password { '123456' }
    birthdate { Faker::Date.between(from: '1900-01-01', to: Time.zone.today) }
    cabinet_number { Faker::Number.number(digits: 3) }

    after(:create) do |user|
      user.categories << create_list(:category, 2)
    end
  end
end
