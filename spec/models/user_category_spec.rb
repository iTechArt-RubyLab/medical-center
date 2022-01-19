require 'rails_helper'

RSpec.describe UserCategory, type: :model do
  describe 'invalid create user_category' do
    shared_examples 'Checks that user_category invalid' do
      it 'is invalid' do
        expect(user_category.valid?).to eq(false)
      end
    end

    context "when user is blank" do
      let(:user_category) { build :user_category, user: nil }

      include_examples 'Checks that user_category invalid'
    end

    context "when category is blank" do
      let(:user_category) { build :user_category, category: nil }

      include_examples 'Checks that user_category invalid'
    end
  end
end
