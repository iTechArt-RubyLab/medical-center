require 'rails_helper'

describe V1::Admin::Categories do
  include AuthHelper

  let!(:current_user) { create :user }

  describe 'POST /api/v1/admin/categories' do
    let(:params) do
      {
        title: 'nurse',
        description: 'medical nursing'
      }
    end

    it 'returns created category' do
      post '/api/v1/admin/categories', params: params, headers: headers(current_user)

      expect(response).to redirect_to("/api/v1/admin/categories/#{Category.find_by(title: params[:title]).id}")
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
      put "/api/v1/admin/categories/#{category.id}", params: params, headers: headers(current_user)

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
      delete "/api/v1/admin/categories/?id=#{category.id}", params: params, headers: headers(current_user)

      expect(response).to redirect_to('/api/v1/admin/categories')
    end

    it 'decrease the count by 1' do
      expect do
        delete "/api/v1/admin/categories/?id=#{category.id}", params: params, headers: headers(current_user)
      end.to change(Category, :count).by(-1)
    end
  end
end
