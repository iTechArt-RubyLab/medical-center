module V1
  class Patients < API
    helpers Helpers::CrudHelpers

    resources :patients do
      desc 'Return all patients'
      params do
        optional :sort, type: Hash
      end
      get do
        default_sort = { column_name: 'full_name', type: 'asc' }
        present sorting(Patient, declared(params)[:sort], default_sort), with: Entities::Patient
      end

      desc 'Return a specific patient'
      route_param :id do
        get do
          patient = Patient.find(params[:id])
          present patient, with: Entities::Patient
        end
      end
    end
  end
end
