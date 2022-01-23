# == Schema Information
#
# Table name: diagnoses
#
#  id              :bigint           not null, primary key
#  medication_list :text             not null
#  name            :string           not null
#  symptom         :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_diagnoses_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :diagnosis do
    name { Faker::Lorem.word }
    symptom { Faker::Lorem.sentence(word_count: rand(2..10)) }
    medication_list { Faker::Lorem.sentence(word_count: rand(2..10)) }

    trait :tuberculosis do
      name { 'Tuberculosis' }
      symptom { 'Coughing up blood' }
      medication_list { 'Hematogen' }
    end

    trait :bronchitis do
      name { 'Bronchitis' }
      symptom { 'Dyspnea' }
      medication_list { 'Paracetamol' }
    end

    trait :tonsillitis do
      name { 'Tonsillitis' }
      symptom { 'Sore throat' }
      medication_list { 'Vitamin C' }
    end
  end
end
