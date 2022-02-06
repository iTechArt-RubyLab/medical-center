require 'rails_helper'

describe V1::Users do
  include AuthHelper

  describe 'GET /api/v1/users' do
    it 'returns success code' do
      get '/api/v1/users', params: nil, headers: current_user

      expect(response).to have_http_status(:ok)
    end
  end
end
