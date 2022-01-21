# == Schema Information
#
# Table name: patients
#
#  id                   :bigint           not null, primary key
#  address              :string
#  allergies_additional :text
#  date_of_birth        :datetime
#  email                :string
#  full_name            :string           not null
#  notes                :text
#  telephone_number     :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  passport_id          :string
#
# Indexes
#
#  index_patients_on_email        (email) UNIQUE
#  index_patients_on_passport_id  (passport_id) UNIQUE
#
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
