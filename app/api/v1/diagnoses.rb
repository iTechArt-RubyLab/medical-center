module V1
  class Diagnoses < API
    helpers Helpers::CrudHelpers

    resources :diagnoses do
      desc 'Return all diagnoses'
      params do
        optional :sort, type: Hash
      end
      get do
        default_sort = { column_name: 'name', type: 'asc' }
        present sorting(Diagnosis, declared(params)[:sort], default_sort).paginate(page: params[:page])
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
