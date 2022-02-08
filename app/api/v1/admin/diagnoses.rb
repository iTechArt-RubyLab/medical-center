module V1
  module Admin
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

        desc 'create a new diagnosis'
        post do
          Diagnosis.create!(params)
        end

        desc 'Update a specific diagnosis'
        route_param :id do
          put do
            Diagnosis.find(params[:id]).tap do |diagnosis|
              diagnosis.update!(params)
            end
          end
        end

        desc 'Delete a specific diagnosis'
        route_param :id do
          delete do
            diagnosis = Diagnosis.find(params[:id])

            diagnosis.destroy
          end
        end
      end
    end
  end
end
