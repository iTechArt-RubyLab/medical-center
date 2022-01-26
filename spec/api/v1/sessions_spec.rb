# rubocop:disable RSpec/MultipleExpectations
require 'rails_helper'
RSpec.describe 'sessions', type: :request do
  let(:sign_in_url) { '/api/v1/sessions' }
  let(:sign_in_params) do
    {
      email: 'user@mail.ru',
      password: '12345678'
    }
  end

  before do
    create :user, email: 'user@mail.ru', password: '12345678'
  end

  describe 'POST /api/v1/sessions' do
    context 'when signin params is valid' do
      before do
        post sign_in_url, params: sign_in_params
      end

      it 'returns created user' do
        auth_token = User.last.authentication_token

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['auth_token']).to eq auth_token
      end
    end

    context 'when signup params is invalid' do
      let(:sign_in_params) do
        {
          email: 'user1@mail.ru',
          password: '1234'
        }
      end

      before do
        post sign_in_url, params: sign_in_params
      end

      it 'returns error' do
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)['error']).to eq 'Invalid Email or Password.'
      end
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
