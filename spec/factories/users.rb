FactoryBot.define do
  factory :user do
    full_name { 'Tom Hardi' }
    role { 'common' }
    phone_number { "+375(29)#{Faker::Number.number(digits: 7)}" }
    sequence(:email) do |n|
      "tom.hardi#{n}@mail.ru"
    end
    status { 'working' }
    password { '123456' }
    birthdate { '12.12.2001' }
    cabinet_number { '404' }

    after(:create) do |user|
      user.categories << create_list(:category, 2)
    end
  end
end
