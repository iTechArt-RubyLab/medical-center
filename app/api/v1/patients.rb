module V1
  class Patients < API
    resources :patients do
      desc 'Return all patients'
      params do
        optional :sort, type: Hash
      end
      get do
        present sorting(Patient, declared(params)[:sort]).paginate(page: params[:page]), with: Entities::Patient
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
