require 'rails_helper'

describe V1::Admin::Diagnoses do
  include AuthHelper

  let!(:current_user) { create(:user) }
  let!(:diagnoses) { create_list(:diagnosis, 2) }

  describe 'POST#create' do
    let(:params) do
      {
        name: 'covid',
        symptom: 'very bad',
        medication_list: 'relax'
      }
    end

    it 'returns created diagnosis' do
      post '/api/v1/admin/diagnoses', params: params, headers: headers(current_user)

      expect(Diagnosis.pluck(:id)).to include(JSON.parse(response.body)['id'])
    end
  end

  describe 'PUT#update' do
    let!(:diagnosis) { create(:diagnosis) }
    let(:params) do
      {
        name: 'covid'
      }
    end

    it 'returns updated diagnosis' do
      put "/api/v1/admin/diagnoses/#{diagnosis.id}", params: params, headers: headers(current_user)

      expect(JSON.parse(response.body)['name']).to eq 'covid'
    end
  end

  describe 'DELETE#destroy' do
    it 'returns deleted diagnosis' do
      delete "/api/v1/admin/diagnoses/#{diagnoses.first.id}", params: nil, headers: headers(current_user)

      expect(diagnoses.pluck(:id)).to include(JSON.parse(response.body)['id'])
    end
  end
end
