module V1
  class Allergies < API
    helpers Helpers::CrudHelpers

    resources :allergies do
      desc 'Return all allergies'
      params do
        optional :sort, type: Hash
      end
      get do
        default_sort = { column_name: 'name', type: 'asc' }
        present sorting(Allergy, declared(params)[:sort], default_sort), with: Entities::Allergy
      end

      desc 'Return a specific allergy'
      route_param :id do
        get do
          allergy = Allergy.find(params[:id])
          present allergy, with: Entities::Allergy
        end
      end
    end
  end
end
