module V1
  module Admin
    class Diagnoses < API
      desc 'create a new diagnosis'
      resources :diagnoses do
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
