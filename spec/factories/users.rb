# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  authentication_token   :string(30)
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
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_phone_number          (phone_number) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_status                (status)
#
FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    role { 'common' }
    phone_number { "+375(29)#{Faker::Number.unique.number(digits: 7)}" }
    email { Faker::Internet.unique.email }
    status { 'working' }
    password { '123456' }
    birthdate { Faker::Date.between(from: '1900-01-01', to: Time.zone.today) }
    cabinet_number { Faker::Number.number(digits: 3) }

    after(:create) do |user|
      user.categories << create_list(:category, 2)
    end
  end
end
