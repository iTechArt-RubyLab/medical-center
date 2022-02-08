require 'rails_helper'

describe V1::Admin::Visits, type: :request do
  include AuthHelper

  let!(:current_user) { create(:user, role: 'admin') }
  let(:headers) { { 'Authorization' => current_user.authentication_token.to_s } }
  let!(:visits) { create_list(:visit, 2) }

  describe 'POST#create' do
    let(:patient) { create(:patient) }
    let(:common_doctor) { create(:user) }
    let(:params) do
      {
        cabinet: '305',
        notes: 'kar-kar',
        date: '2022.02.23',
        patient_id: patient.id,
        user_id: common_doctor.id
      }
    end

    it 'returns created visit' do
      post '/api/v1/admin/visits', params: params, headers: headers

      expect(Visit.pluck(:id)).to include(JSON.parse(response.body)['id'])
    end
  end

  describe 'PUT#update' do
    let(:visit) { create :visit }
    let(:note) { 'without any chances' }
    let(:params) do
      {
        notes: note
      }
    end

    it 'returns updated diagnosis' do
      put "/api/v1/admin/visits/#{visit.id}", params: params, headers: headers

      expect(note).to include(JSON.parse(response.body)['notes'])
    end
  end

  describe 'DELETE#destroy' do
    it 'returns deleted visit' do
      delete "/api/v1/admin/visits/#{visits.first.id}", params: nil, headers: headers

      expect(JSON.parse(response.body)['id']).to eq visits.first.id
    end
  end
end
