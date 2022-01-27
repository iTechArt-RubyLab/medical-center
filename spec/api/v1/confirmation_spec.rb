require 'rails_helper'

RSpec.describe 'confirmations', type: :request do
  let(:confirmation_url) { '/api/v1/confirmations' }
  let(:user) { create(:user) }
  let(:confirmation_params) { { confirm_token: user.confirm_token } }

  describe 'POST /api/v1/confirmations' do
    context 'when confirm_token is correct' do
      before do
        user.email_activate
        post confirmation_url, params: confirmation_params
      end

      it 'confirms the user' do
        expect(JSON.parse(response.body)).to eq true
      end

      it 'email_confirmed is true' do
        expect(user.email_confirmed).to eq true
      end

      it 'confirm_token is nil' do
        expect(user.confirm_token).to eq nil
      end
    end

    context 'when confirm_token is incorrect' do
      let(:confirmation_params) { { confirm_token: '123' } }

      before do
        post confirmation_url, params: confirmation_params
      end

      it "doesn't confirm the user" do
        expect(JSON.parse(response.body)).to eq nil
      end

      it 'email_confirmed is false' do
        expect(user.email_confirmed).to eq false
      end
    end
  end
end
