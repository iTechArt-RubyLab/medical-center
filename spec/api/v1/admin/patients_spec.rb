require 'rails_helper'
require 'active_record'
RSpec.describe V1::Admin::Patients, type: :request do
  include AuthHelper

  let(:patients_crud_url) { '/api/v1/admin/patients' }
  let(:patients_params) do
    {
      address: Faker::Address.full_address,
      date_of_birth: Faker::Date.between(from: '1900-01-01', to: Time.zone.today),
      email: Faker::Internet.email,
      full_name: Faker::Name.name,
      notes: 'Something notes',
      telephone_number: Faker::Number.number(digits: 7),
      passport_id: Faker::Alphanumeric.alpha(number: rand(6..50)),
      allergies_additional: 'Something information about allergies',
      allergies_ids: nil
    }
  end
  let(:current_user) { create :user, role: 'admin' }
  let(:headers) { { 'Authorization' => current_user.authentication_token.to_s } }

  before do
    create_list(:patient, 5)
  end

  describe 'GET /api/v1/admin/patients' do
    context 'when all records are requested' do
      before do
        get patients_crud_url, headers: headers
      end

      it 'returns all patients' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /api/v1/admin/patients/_id_' do
    context 'when record exists' do
      before do
        get "#{patients_crud_url}/#{Patient.all.sample.id}", headers: headers
      end

      it 'return patient' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the request is invalid' do
      before do
        get "#{patients_crud_url}/abc", headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/admin/patients/' do
    context 'when params are valid' do
      before do
        post patients_crud_url, params: patients_params, headers: headers
      end

      it 'redirect to new patient' do
        expect(response).to redirect_to(
          "#{patients_crud_url}/#{Patient.find_by(passport_id: patients_params[:passport_id]).id}"
        )
      end
    end

    context 'when passport_id has already been used' do
      before do
        post patients_crud_url, params: patients_params.merge(passport_id: Patient.all.sample.passport_id),
                                headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when one of parameters missing' do
      before do
        post patients_crud_url, params: patients_params.except(:full_name), headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PUT /api/v1/admin/patients/_id_' do
    context 'when params are valid' do
      before do
        put "#{patients_crud_url}/#{Patient.all.sample.id}", params: patients_params, headers: headers
      end

      it 'response have code :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'patient are updated' do
        expect(JSON.parse(response.body)['passport_id']).to eq patients_params[:passport_id]
      end
    end

    context 'when passport_id has already been used' do
      let(:updatable_patient) { Patient.all.sample }
      let(:rand_passport_id) { Patient.all.excluding(updatable_patient).sample.passport_id }

      before do
        put "#{patients_crud_url}/#{updatable_patient.id}",
            params: patients_params.merge(passport_id: rand_passport_id), headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when one of parameters missing' do
      before do
        put "#{patients_crud_url}/#{Patient.all.sample.id}", params: patients_params.except(:full_name),
                                                             headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /api/v1/admin/patients/_id_' do
    context 'when patient exist' do
      before do
        delete patients_crud_url, params: { id: Patient.all.sample.id }, headers: headers
      end

      it 'request redirected' do
        expect(response).to redirect_to(patients_crud_url)
      end
    end

    context 'when patient does not exist' do
      before do
        delete patients_crud_url, params: { id: (Patient.last.id + 1) }, headers: headers
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
