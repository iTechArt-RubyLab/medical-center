require 'rails_helper'
require 'active_record'
# rubocop:disable RSpec/MultipleExpectations
RSpec.describe 'patient', type: :request do
  let(:patients_crud_url) { '/api/v1/patients' }
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
      allergies: ''
    }
  end

  before do
    create_list :patient, 5
  end

  describe 'GET /api/v1/patients' do
    context 'when all records are requested' do
      before do
        get patients_crud_url
      end

      it 'returns all patients' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /api/v1/patients/_id_' do
    context 'when record exists' do
      before do
        patient_url = "#{patients_crud_url}/#{Patient.all.sample.id}"
        get patient_url
      end

      it 'return patient' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the request is invalid' do
      before do
        get "#{patients_crud_url}/abc"
      end

      it 'server return error message' do
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)['error_message']).to eq 'Patient not found'
      end
    end
  end

  describe 'POST /api/v1/patients/' do
    context 'when params are valid' do
      before do
        post patients_crud_url, params: patients_params
      end

      it 'create new patient and redirect to him' do
        expect(response).to redirect_to(
          "#{patients_crud_url}/#{Patient.find_by(passport_id: patients_params[:passport_id]).id}"
        )
      end
    end

    context 'when passport_id has already been used' do
      before do
        used_passport_id_params = patients_params
        used_passport_id_params[:passport_id] = Patient.all.sample.passport_id
        post patients_crud_url, params: used_passport_id_params
      end

      it 'server return error message' do
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)['error_message']).to eq 'Passport has already been taken'
      end
    end

    context 'when one of parameters missing' do
      before do
        missing_parameters_params = patients_params
        missing_parameters_params.except!(:full_name)
        post patients_crud_url, params: missing_parameters_params
      end

      it 'server return error message' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PUT /api/v1/patients/_id_' do
    context 'when params are valid' do
      before do
        patient = Patient.all.sample
        put "#{patients_crud_url}/#{patient.id}", params: patients_params
      end

      it 'update patient and show him' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['passport_id']).to eq patients_params[:passport_id]
      end
    end

    context 'when passport_id has already been used' do
      before do
        patient = Patient.all.sample
        used_passport_id_params = patients_params
        used_passport_id_params[:passport_id] = Patient.all.excluding(patient).sample.passport_id
        put "#{patients_crud_url}/#{patient.id}", params: used_passport_id_params
      end

      it 'server return error message' do
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)['error_message']).to eq 'Passport has already been taken'
      end
    end

    context 'when one of parameters missing' do
      before do
        patient = Patient.all.sample
        missing_parameters_params = patients_params
        missing_parameters_params.except!(:full_name)
        put "#{patients_crud_url}/#{patient.id}", params: missing_parameters_params
      end

      it 'server return error message' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /api/v1/patients/_id_' do
    context 'when patient exist' do
      before do
        delete patients_crud_url, params: { id: Patient.all.sample.id }
      end

      it 'patient deleted and redirected' do
        expect(response).to redirect_to(patients_crud_url)
      end
    end

    context 'when patient does not exist' do
      before do
        delete patients_crud_url, params: { id: (Patient.last.id + 1) }
      end

      it 'server return error' do
        expect(JSON.parse(response.body)['error_code']).to eq 404
      end
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
