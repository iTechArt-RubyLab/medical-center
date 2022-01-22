# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birthdate              :date             not null
#  cabinet_number         :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string           not null
#  phone_number           :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("common"), not null
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_phone_number          (phone_number) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_status                (status)
#
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
