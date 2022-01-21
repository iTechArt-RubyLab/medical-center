# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birthdate              :date             not null
#  cabinet_number         :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string           not null
#  phone_number           :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("common"), not null
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_phone_number          (phone_number) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_status                (status)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'invalid create user' do
    shared_examples 'Checks that user invalid' do
      it 'is invalid' do
        expect(user.valid?).to eq(false)
      end
    end

    let(:email) { 'arsenij@mail.ru' }
    let(:phone) { '+375295673205' }

    before { create :user, email: email, phone_number: phone }

    context 'when name is blank' do
      let(:user) { build :user, full_name: nil }

      include_examples 'Checks that user invalid'
    end

    context 'when email is blank' do
      let(:user) { build :user, email: nil }

      include_examples 'Checks that user invalid'
    end

    context 'when email is duplicated' do
      let(:user) { build :user, email: email }

      include_examples 'Checks that user invalid'
    end

    context 'when phone is blank' do
      let(:user) { build :user, phone_number: nil }

      include_examples 'Checks that user invalid'
    end

    context 'when phone is duplicated' do
      let(:user) { build :user, phone_number: phone }

      include_examples 'Checks that user invalid'
    end

    context 'when birthdate is blank' do
      let(:user) { build :user, birthdate: nil }

      include_examples 'Checks that user invalid'
    end

    context 'when birthdate is correct' do
      let(:user) { build :user, birthdate: '01.01.1899' }

      include_examples 'Checks that user invalid'
    end

    context 'when role is blank' do
      let(:user) { build :user, role: nil }

      include_examples 'Checks that user invalid'
    end

    context 'when cabinet_number is blank' do
      let(:user) { build :user, cabinet_number: nil }

      include_examples 'Checks that user invalid'
    end

    context 'when status is blank' do
      let(:user) { build :user, status: nil }

      include_examples 'Checks that user invalid'
    end
  end
end
