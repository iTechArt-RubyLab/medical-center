# == Schema Information
#
# Table name: user_categories
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_user_categories_on_category_id  (category_id)
#  index_user_categories_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserCategory, type: :model do
  describe 'invalid create user_category' do
    shared_examples 'Checks that user_category invalid' do
      it 'is invalid' do
        expect(user_category.valid?).to eq(false)
      end
    end

    context 'when user is blank' do
      let(:user_category) { build :user_category, user: nil }

      include_examples 'Checks that user_category invalid'
    end

    context 'when category is blank' do
      let(:user_category) { build :user_category, category: nil }

      include_examples 'Checks that user_category invalid'
    end
  end
end
