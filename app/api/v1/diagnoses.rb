module V1
  class Diagnoses < API
    desc 'create a new diagnosis'
    params do
      requires :name, type: String
      requires :symptom, type: String
      requires :medication_list, type: String
    end

    resources :diagnoses do
      
      desc 'Return all diagnoses'
      get do
        @diagnoses = Diagnosis.all
        present @diagnoses
      end

      desc 'Return specific diagnosis'
      route_param :id, type: Integer do
        get do
          diagnosis = Diagnosis.find(params[:id])
          { diagnosis: diagnosis }
        end
      end
    end
  end
end
