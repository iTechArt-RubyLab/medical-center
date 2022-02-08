require 'rails_helper'

describe V1::Admin::Categories do
  include AuthHelper

  let!(:current_user) { create :user, role: 'admin' }
  let(:headers) { { 'Authorization' => current_user.authentication_token.to_s } }

  describe 'POST /api/v1/admin/categories' do
    let(:params) do
      {
        title: 'nurse',
        description: 'medical nursing'
      }
    end

    it 'returns created category' do
      post '/api/v1/admin/categories', params: params, headers: headers

      expect(JSON.parse(response.body)['title']).to eq(params[:title])
    end
  end

  describe 'PUT /api/v1/admin/categories/:id' do
    let!(:category) { create :category, title: 'Nurse' }
    let(:params) do
      {
        title: 'Dentist'
      }
    end

    it 'returns updated category' do
      put "/api/v1/admin/categories/#{category.id}", params: params, headers: headers

      expect(JSON.parse(response.body)['title']).to eq 'Dentist'
    end
  end

  describe 'DELETE /api/v1/admin/categories/:id' do
    let!(:category) { create :category }
    let(:params) do
      {
        id: category.id
      }
    end

    it 'redirects after successful delete' do
      delete "/api/v1/admin/categories/?id=#{category.id}", params: params, headers: headers

      expect(JSON.parse(response.body)['id']).to eq(category.id)
    end

    it 'decrease the count by 1' do
      expect do
        delete "/api/v1/admin/categories/?id=#{category.id}", params: params, headers: headers
      end.to change(Category, :count).by(-1)
    end
  end
end
