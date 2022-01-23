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
require 'rails_helper'

RSpec.describe Patient, type: :model do
  after do
    described_class.delete_all
  end

  describe 'patient_factory' do
    let(:valid_patient) { create(:patient) }

    it 'is valid' do
      expect(valid_patient).to be_valid
    end

    it 'is not valid without a full name' do
      another_patient = build(:patient, full_name: nil)
      expect(another_patient).not_to be_valid
    end

    it 'is not valid with incorrect email' do
      another_patient = build(:patient, email: Faker::Alphanumeric.alpha(number: rand(1..100)))
      expect(another_patient).not_to be_valid
    end

    it 'has a unique email' do
      another_patient = build(:patient, email: valid_patient.email)
      expect(another_patient).not_to be_valid
    end

    it 'is not valid without a telephone number' do
      another_patient = build(:patient, telephone_number: nil)
      expect(another_patient).not_to be_valid
    end

    it 'is not valid with incorrect telephone number' do
      another_patient = build(:patient, telephone_number: Faker::Alphanumeric.alpha(number: rand(1..3)))
      expect(another_patient).not_to be_valid
    end

    it 'is not valid without a date of birth' do
      another_patient = build(:patient, date_of_birth: nil)
      expect(another_patient).not_to be_valid
    end

    it 'is not valid with incorrect date of birth' do
      another_patient = build(:patient, date_of_birth: Faker::Date.forward(days: 1))
      expect(another_patient).not_to be_valid
    end

    it 'is not valid without a passport number' do
      another_patient = build(:patient, passport_id: nil)
      expect(another_patient).not_to be_valid
    end

    it 'is not valid with incorrect passport number' do
      another_patient = build(:patient, passport_id: Faker::Alphanumeric.alpha(number: rand(1..3)))
      expect(another_patient).not_to be_valid
    end

    it 'has a unique passport number' do
      another_patient = build(:patient, passport_id: valid_patient.passport_id)
      expect(another_patient).not_to be_valid
    end

    it 'is not valid without a address' do
      another_patient = build(:patient, address: nil)
      expect(another_patient).not_to be_valid
    end
  end
end
