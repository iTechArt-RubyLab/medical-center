module V1
  module Admin
    class Diagnoses < API
      desc 'create a new diagnosis'
      params do
        requires :name, type: String
        requires :symptom, type: String
        requires :medication_list, type: String
      end

      resources :diagnoses do
        
        post do
          Diagnosis.create!(params)
        end

        desc 'Update a specific diagnosis'
        route_param :id do
          put do
            diagnosis = Diagnosis.find(params[:id])

            diagnosis.update(params)
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
