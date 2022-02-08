require 'rails_helper'

describe V1::Admin::SickLeaves, type: :request do
  include AuthHelper

  let!(:sick_leaves) { create_list(:sick_leave, 2) }

  describe 'DELETE#destroy' do
    it 'returns deleted sickleave' do
      delete "/api/v1/admin/sick_leaves/#{sick_leaves.first.id}", params: nil, headers: headers(current_user)

      expect(JSON.parse(response.body)['id']).to eq sick_leaves.first.id
    end
  end
end
