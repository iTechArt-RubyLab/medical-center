# rubocop:disable RSpec/MultipleExpectations
require 'rails_helper'
RSpec.describe 'registrations', type: :request do
  let(:sign_up_url) { '/api/v1/registrations' }
  let(:sign_up_params) do
    {
      email: 'user@mail.ru',
      password: '12345678',
      password_confirmation: '12345678',
      cabinet_number: '404',
      birthdate: '22/01/2019',
      phone_number: '1238816',
      full_name: 'User'
    }
  end

  describe 'POST /api/v1/registrations' do
    context 'when signup params are valid' do
      before do
        post sign_up_url, params: sign_up_params
      end

      it 'returns created user' do
        auth_token = User.last.authentication_token

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['auth_token']).to eq auth_token
      end
    end

    context 'when signup params are invalid' do
      let(:error_message) { 'Validation failed: Phone number is the wrong length (should be 7 characters)' }
      let(:wrong_sign_up_params) do
        {
          email: 'user1@mail.ru',
          password: '12345678',
          password_confirmation: '12345678',
          cabinet_number: '404',
          birthdate: '22/01/2019',
          phone_number: '12345678',
          full_name: 'User'
        }
      end

      before do
        post sign_up_url, params: wrong_sign_up_params
      end

      it 'returns error' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq error_message
      end
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
