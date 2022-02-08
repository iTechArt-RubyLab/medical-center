require 'rails_helper'

describe V1::Visits do
  include AuthHelper

  let!(:current_user) { create(:user) }
  let!(:visit) { create(:visit, user: current_user) }

  describe 'GET all visits' do
    it 'returns current_users visits' do
      get '/api/v1/visits', params: nil, headers: headers(current_user)

      expect(JSON.parse(response.body).count).to eq current_user.visits.count
    end
  end

  describe 'POST method' do
    let(:patient) { create :patient }
    let(:params) do
      {
        cabinet: '305',
        notes: 'kar-kar',
        date: '2022.02.23',
        patient_id: patient.id
      }
    end

    # it 'returns new current_users visit' do
    #   post '/api/v1/visits', params: params, headers: headers(current_user)

    #   expected_id = Visit.last.id

    #   expect(JSON.parse(response.body)['id']).to eq expected_id
    # end
  end

  # describe 'GET specific visit' do
  #   it 'returns current_users visits by id' do
  #     get "/api/v1/visits/#{visit.id}", params: nil, headers: headers(current_user)

  #     expect(JSON.parse(response.body)['id']).to eq visit.id
  #   end
  # end
end
