require 'rails_helper'

describe V1::Diagnoses do
  include AuthHelper
  
  let!(:current_user) { create :user }
  let!(:diagnoses) { create_list :diagnosis, 2 }

  describe 'GET /api/v1/diagnoses' do
    it 'returns all diagnoses' do
      get '/api/v1/diagnoses', params: nil, headers: headers(current_user)      

      expect(JSON.parse(response.body).count).to eq Diagnosis.count
    end
  end

  describe 'GET /api/v1/diagnoses/:id' do
    it 'returns diagnosis found by id' do
      get "/api/v1/diagnoses/#{diagnoses.first.id}", params: nil, headers: headers(current_user)

      expect(JSON.parse(response.body)['id']).to eq diagnoses.first.id
    end
  end
end
