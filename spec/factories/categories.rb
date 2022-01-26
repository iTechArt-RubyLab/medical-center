# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  description :text
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_categories_on_title  (title) UNIQUE
#
FactoryBot.define do
  factory :category do
    title { Faker::Lorem.unique.word }
    description { Faker::Lorem.sentence(word_count: 5) }

    trait :dentist do
      title { 'Dentist' }
      description { 'Dental treatment' }
    end

    trait :ophthalmologist do
      title { 'Ophthalmologist' }
      description { 'Vision treatment' }
    end

    trait :pediatrician do
      title { 'Pediatrician' }
      description { 'Treatment of common diseases' }
    end
  end
end
