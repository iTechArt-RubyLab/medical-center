require 'rails_helper'

RSpec.describe Allergy, type: :model do
  before(:all) do
    @allergy1 = FactoryBot.create(:allergy)
  end

  describe 'valid allergy factory' do
    context 'factory' do
      it 'is valid with valid attributes' do
        expect(@allergy1).to be_valid
      end
    end
  end

  it 'is not valid without a name' do
    patient2 = FactoryBot.build(:allergy, name: nil)
    expect(patient2).not_to be_valid
  end

  it 'is not valid with incorrect name' do
    patient2 = FactoryBot.build(:allergy, name: Faker::Alphanumeric.alpha(number: rand(51..100)))
    expect(patient2).not_to be_valid
  end

  it 'has a unique name' do
    patient2 = FactoryBot.build(:allergy, name: @allergy1.name)
    expect(patient2).not_to be_valid
  end
end
