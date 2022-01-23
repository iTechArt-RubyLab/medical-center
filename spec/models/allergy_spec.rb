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
require 'rails_helper'

RSpec.describe Allergy, type: :model do
  after do
    described_class.delete_all
  end

  describe 'allergy_factory' do
    let(:valid_allergy) { create(:allergy) }

    it 'is valid' do
      expect(valid_allergy).to be_valid
    end

    it 'is not valid without a name' do
      another_allergy = build(:allergy, name: nil)
      expect(another_allergy).not_to be_valid
    end

    it 'is not valid with incorrect name' do
      another_allergy = build(:allergy, name: Faker::Alphanumeric.alpha(number: rand(51..100)))
      expect(another_allergy).not_to be_valid
    end

    it 'has a unique name' do
      another_allergy = build(:allergy, name: valid_allergy.name)
      expect(another_allergy).not_to be_valid
    end
  end
end
