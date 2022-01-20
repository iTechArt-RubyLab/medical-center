require 'rails_helper'

RSpec.describe Patient, type: :model do
  before(:all) do
    @patient1 = FactoryBot.create(:patient)
  end

  describe 'valid patient factory' do
    context 'factory' do
      it 'is valid with valid attributes' do
        expect(@patient1).to be_valid
      end
    end
  end

  it 'is not valid without a full name' do
    patient2 = FactoryBot.build(:patient, full_name: nil)
    expect(patient2).not_to be_valid
  end

  it 'is not valid with incorrect email' do
    patient2 = FactoryBot.build(:patient, email: Faker::Alphanumeric.alpha(number: rand(1..100)))
    expect(patient2).not_to be_valid
  end

  it 'has a unique email' do
    patient2 = FactoryBot.build(:patient, email: @patient1.email)
    expect(patient2).not_to be_valid
  end

  it 'is not valid without a telephone number' do
    patient2 = FactoryBot.build(:patient, telephone_number: nil)
    expect(patient2).not_to be_valid
  end

  it 'is not valid with incorrect telephone number' do
    patient2 = FactoryBot.build(:patient, telephone_number: Faker::Alphanumeric.alpha(number: rand(1..3)))
    expect(patient2).not_to be_valid
  end

  it 'is not valid without a date of birth' do
    patient2 = FactoryBot.build(:patient, date_of_birth: nil)
    expect(patient2).not_to be_valid
  end

  it 'is not valid with incorrect date of birth' do
    patient2 = FactoryBot.build(:patient, date_of_birth: Faker::Date.forward(days: 1))
    expect(patient2).not_to be_valid
  end

  it 'is not valid without a passport number' do
    patient2 = FactoryBot.build(:patient, passport_id: nil)
    expect(patient2).not_to be_valid
  end

  it 'is not valid with incorrect passport number' do
    patient2 = FactoryBot.build(:patient, passport_id: Faker::Alphanumeric.alpha(number: rand(1..3)))
    expect(patient2).not_to be_valid
  end

  it 'has a unique passport number' do
    patient2 = FactoryBot.build(:patient, passport_id: @patient1.passport_id)
    expect(patient2).not_to be_valid
  end

  it 'is not valid without a address' do
    patient2 = FactoryBot.build(:patient, address: nil)
    expect(patient2).not_to be_valid
  end
end
