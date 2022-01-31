require 'rails_helper'

describe V1::Admin::Visits, type: :request do
  include AuthHelper

  let!(:current_user) { create(:user) }
  let!(:visits) { create_list(:visit, 2) }

  describe 'POST method' do
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
      post '/api/v1/admin/visits', params: params, headers: headers(current_user)
      # test fields
      expect(Visit.pluck(:id)).to include(JSON.parse(response.body)['id'])
    end
  end

  describe 'PUT method' do
    let(:visit) { create :visit }
    let(:note) { 'without any chances' }
    let(:params) do
      {
        notes: note
      }
    end

    it 'returns updated diagnosis' do
      put "/api/v1/admin/visits/#{visit.id}", params: params, headers: headers(current_user)

      expect(note).to include(JSON.parse(response.body)['notes'])
    end
  end

  describe 'DELETE method' do
    it 'returns deleted visit' do
      delete "/api/v1/admin/visits/#{visits.first.id}", params: nil, headers: headers(current_user)

      expect(JSON.parse(response.body)['id']).to eq visits.first.id
    end
  end
end
