module V1
  class Allergies < API
    resources :allergies do
      desc 'Return all allergies'
      params do
        optional :sort, type: Hash
      end
      get do
        present sorting(Allergy, declared(params)[:sort]).paginate(page: params[:page]), with: Entities::Allergy
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
