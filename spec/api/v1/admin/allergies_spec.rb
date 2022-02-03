require 'rails_helper'
require 'active_record'
RSpec.describe V1::Admin::Allergies, type: :request do
  let(:allergies_crud_url) { '/api/v1/admin/allergies' }
  let(:allergies_params) { name: 'New allergy name' }

  before do
    5.times do |i|
      Allergy.create!(name: "Test allergy #{i}")
    end
  end
end
