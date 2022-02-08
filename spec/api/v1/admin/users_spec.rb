require 'rails_helper'

describe V1::Admin::Users do
  include AuthHelper

  let(:current_user) { create :user, role: 'admin' }
  let(:headers) { { 'Authorization' => current_user.authentication_token.to_s } }

  describe 'GET method' do
    it 'returns success code' do
      get '/api/v1/admin/users', params: nil, headers: headers

      expect(response).to have_http_status(:ok)
    end
  end
end
