require 'rails_helper'

RSpec.describe Category, type: :model do

  describe 'invalid create category' do
    shared_examples 'Checks that category invalid' do
      it 'is invalid' do
        expect(category.valid?).to eq(false)
      end
    end

    context "when title is blank" do
      let(:category) { build :category, title: nil }

      include_examples 'Checks that category invalid'
    end

    context "when title is duplicated" do
      let(:title) { 'Dentist' }
      let!(:correct_category) { create :category, title: title }
      let!(:category) { build :category, title: title }

      include_examples 'Checks that category invalid'
    end
  end
end
