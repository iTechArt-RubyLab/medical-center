module V1
  class Diagnoses < API
    resources :diagnoses do
      desc 'Return all diagnoses'
      params do
        optional :sort, type: Hash
      end
      get do
        present sorting(Diagnosis, declared(params)[:sort]).paginate(page: params[:page])
      end

      desc 'Return specific diagnosis'
      route_param :id, type: Integer do
        get do
          present Diagnosis.find(params[:id])
        end
      end
    end
  end
end
