require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'invalid create user' do
    shared_examples 'Checks that user invalid' do
      it 'is invalid' do
        expect(user.valid?).to eq(false)
      end
    end

    context "when name is blank" do
      let(:user) { build :user, full_name: nil }

      include_examples 'Checks that user invalid'
    end

    context "when email is blank" do
      let(:user) { build :user, email: nil }

      include_examples 'Checks that user invalid'
    end

    context "when email is duplicated" do
      let(:email) { 'arsenij@mail.ru' }
      let!(:correct_user) { create :user, email: email }
      let!(:user) { build :user, email: email }

      include_examples 'Checks that user invalid'
    end

    context "when phone is blank" do
      let(:user) { build :user, phone_number: nil }

      include_examples 'Checks that user invalid'
    end

    context "when phone is duplicated" do
      let(:phone) { '+375295673205' }
      let!(:correct_user) { create :user, phone_number: phone }
      let!(:user) { build :user, phone_number: phone }

      include_examples 'Checks that user invalid'
    end

    context "when birthdate is blank" do
      let(:user) { build :user, birthdate: nil }

      include_examples 'Checks that user invalid'
    end

    context "when birthdate is correct" do
      let(:user) { build :user, birthdate: '01.01.1899' }

      include_examples 'Checks that user invalid'
    end

    context "when role is blank" do
      let(:user) { build :user, role: nil }

      include_examples 'Checks that user invalid'
    end

    context "when cabinet_number is blank" do
      let(:user) { build :user, cabinet_number: nil }

      include_examples 'Checks that user invalid'
    end

    context "when status is blank" do
      let(:user) { build :user, status: nil }

      include_examples 'Checks that user invalid'
    end
  end
end
