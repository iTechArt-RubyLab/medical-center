require 'rails_helper'

describe V1::SickLeaves, type: :request do
  include AuthHelper

  let!(:sick_leaves) { create_list(:sick_leave, 2) }

  describe 'POST#create' do
    let(:params) do
      {
        destination: 'ItechArt',
        ended_at: '2022.02.23',
        started_at: '2022.01.17'
      }
    end

    it 'returns created sickleave' do
      post '/api/v1/sick_leaves', params: params, headers: headers(current_user)

      expect(SickLeave.pluck(:id)).to include(JSON.parse(response.body)['id'])
    end
  end

  describe 'PUT#update' do
    let(:sick_leave) { create(:sick_leave) }
    let(:destination) { 'mikrob' }
    let(:params) do
      {
        destination: destination
      }
    end

    it 'returns updated sickleave' do
      put "/api/v1/sick_leaves/#{sick_leave.id}", params: params, headers: headers(current_user)

      expect(destination).to include(JSON.parse(response.body)['destination'])
    end
  end

  describe 'GET#show' do
    let(:sick_leave) { create(:sick_leave) }

    it 'returns sickleave by id' do
      get "/api/v1/sick_leaves/#{sick_leave.id}", params: nil, headers: headers(current_user)

      expect(JSON.parse(response.body)['id']).to eq sick_leave.id
    end
  end

  describe 'GET#index' do
    it 'returns current_users sickleave' do
      get '/api/v1/sick_leaves', params: nil, headers: headers(current_user)

      expect(JSON.parse(response.body).count).to eq sick_leaves.count
    end
  end
end
