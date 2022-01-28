require 'rails_helper'
Rspec.describe 'patient', type: :request do
  let(:patients_crud_url) { '/api/v1/patients' }
  let(:users_params) do
    {
      address: 'Test address',
      :date_of_birth,
      :email,
      :full_name,
      :notes,
      :telephone_number,
      :passport_id,
      :allergies_additional,
      :allergies
    }
end
