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
require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'invalid create category' do
    shared_examples 'Checks that category invalid' do
      it 'is invalid' do
        expect(category.valid?).to eq(false)
      end
    end

    let(:title) { 'Dentist' }

    before { create :category, title: title }

    context 'when title is blank' do
      let(:category) { build :category, title: nil }

      include_examples 'Checks that category invalid'
    end

    context 'when title is duplicated' do
      let(:category) { build :category, title: title }

      include_examples 'Checks that category invalid'
    end
  end
end
