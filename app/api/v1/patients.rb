module V1
  class Patients < API
    resources :patients do
      desc 'Return all patients'
      get do
        @patients = Patient.all
        present @patients, with: Entities::Patient
      end

      desc 'Return specific patient'
      route_param :id, type: Integer do
        get do
          @patient = Patient.find(params[:id])
          present @patient, with: Entities::Patient
        end
      end

      desc 'Create new patient'
      post do
        params[:address]
        params[:date_of_birth]
        params[:email]
        params[:full_name]
        params[:notes]
        params[:telephone_number]
        params[:passport_id]
        params[:allergies_additional]

        patient = Patient.new(params)
        if patient.save
          redirect to patient
        else
          error!({ error_code: 404, error_message: 'Invalid Email or Password.' }, 401)
          return
        end
      end
    end
  end
end
