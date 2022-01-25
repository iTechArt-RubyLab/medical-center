# == Schema Information
#
# Table name: allergies
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_allergies_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :allergy do
    name { Faker::Lorem.unique.word }

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
