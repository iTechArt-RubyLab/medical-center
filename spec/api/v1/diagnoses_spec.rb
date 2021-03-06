require 'rails_helper'

describe V1::Diagnoses do
  include AuthHelper

  let!(:current_user) { create(:user) }
  let!(:diagnoses) { create_list(:diagnosis, 2) }
  let(:headers) { { 'Authorization' => current_user.authentication_token.to_s } }

  describe 'GET#index all diagnoses' do
    it 'returns all diagnoses' do
      get '/api/v1/diagnoses', params: nil, headers: headers

      expect(JSON.parse(response.body).count).to eq Diagnosis.count
    end
  end

  describe 'GET#show specific diagnosis' do
    it 'returns diagnosis found by id' do
      get "/api/v1/diagnoses/#{diagnoses.first.id}", params: nil, headers: headers

      expect(JSON.parse(response.body)['id']).to eq diagnoses.first.id
    end
  end
end
