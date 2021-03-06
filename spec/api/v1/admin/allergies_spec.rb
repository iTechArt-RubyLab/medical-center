require 'rails_helper'
require 'active_record'

RSpec.describe V1::Admin::Allergies, type: :request do
  include AuthHelper

  let!(:current_user) { create(:user, role: 'admin') }
  let(:allergies_crud_url) { '/api/v1/admin/allergies' }
  let(:allergies_params) { { name: 'New allergy name' } }
  let(:headers) { { 'Authorization' => current_user.authentication_token.to_s } }

  before do
    5.times do |i|
      Allergy.create!(name: "Test allergy #{i}")
    end
  end

  describe 'GET /api/v1/admin/allergies' do
    context 'when all records are requested' do
      it 'returns all allergies' do
        get allergies_crud_url, headers: headers

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /api/v1/admin/allergies/_id_' do
    context 'when record exists' do
      before do
        get "#{allergies_crud_url}/#{Allergy.all.sample.id}", headers: headers
      end

      it 'return allergy' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the request is invalid' do
      before do
        get "#{allergies_crud_url}/abc", headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/admin/allergies' do
    context 'when params are valid' do
      before do
        post allergies_crud_url, params: allergies_params, headers: headers
      end

      it 'redirect to new allergy' do
        expect(response).to redirect_to(
          "#{allergies_crud_url}/#{Allergy.find_by(name: allergies_params[:name]).id}"
        )
      end
    end

    context 'when name are used' do
      before do
        post allergies_crud_url, params: { name: Allergy.all.sample.name }, headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when params are empty' do
      before do
        post allergies_crud_url, headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PUT /api/v1/admin/allergies/_id_' do
    context 'when params are valid' do
      before do
        put "#{allergies_crud_url}/#{Allergy.all.sample.id}", params: { name: 'Test name' }, headers: headers
      end

      it 'response have code :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'allergy are updated' do
        expect(JSON.parse(response.body)['name']).to eq 'Test name'
      end
    end

    context 'when name has already been used' do
      let(:updatable_allergy) { Allergy.all.sample }

      before do
        put "#{allergies_crud_url}/#{updatable_allergy.id}",
            params: { name: Allergy.all.excluding(updatable_allergy).sample.name }, headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when name is missing' do
      before do
        put "#{allergies_crud_url}/#{Allergy.all.sample.id}", headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /api/v1/admin/allergies/_id_' do
    context 'when allergy exist' do
      before do
        delete allergies_crud_url, params: { id: Allergy.all.sample.id }, headers: headers
      end

      it 'request redirected' do
        expect(response).to redirect_to(allergies_crud_url)
      end
    end

    context 'when allergy does not exist' do
      before do
        delete allergies_crud_url, params: { id: (Allergy.last.id + 1) }, headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
