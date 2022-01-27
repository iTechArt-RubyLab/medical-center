module V1
  class Patients < API
    resources :patients do
      desc 'Return all patients'
      get do
        patients = Patient.all
        present patients, with: Entities::Patient
      end

      desc 'Return a specific patient'
      route_param :id do
        get do
          begin
            patient = Patient.find(params[:id])
            present patient, with: Entities::Patient
          rescue
            error!({ error_code: 404, error_message: 'Patient not found' })
          end
        end
      end

      desc 'Create a new patient'
      params do
        requires :address
        requires :date_of_birth
        requires :email
        requires :full_name
        requires :notes
        requires :telephone_number
        requires :passport_id
        requires :allergies_additional
        requires :allergies
      end
      post do
        patient = Patient.create(
          address: params[:address],
          date_of_birth: params[:date_of_birth],
          email: params[:email],
          full_name: params[:full_name],
          notes: params[:notes],
          telephone_number: params[:telephone_number],
          passport_id: params[:passport_id],
          allergies_additional: params[:allergies_additional],
        )
        params[:allergies].split(/,/).each do |allergy_id|
          begin
            patient.allergies << Allergy.find(allergy_id)
          rescue
            error!({ error_code: 404, error_message: 'Invalid allergies' })
          end
        end
        if patient.valid?
          patient.save
          redirect "/api/v1/patients/#{patient.id}"
        else
          error!({ error_code: 404, error_message: "#{patient.errors.full_messages.to_sentence}" })
        end
      end

      # desc 'Update an existing patient'
      # post do
      #   begin
      #     patient = Patient.find(params[:id])
      #   rescue
      #     error!({ error_code: 404, error_message: 'Patient not found' })
      #   end
      #   present patient, with: Entities::Patient
      #   patient.update(params)
      # end

      desc 'Delete patient'
      params do
        requires :id
      end
      delete do
        begin
          patient = Patient.find(params[:id])
        rescue
          error!({ error_code: 404, error_message: 'Patient not found' })
        end
        begin
          patient.destroy!
          redirect '/api/v1/patients'
        rescue
          error!({ error_code: 404, error_message: 'Patient cannot be deleted' })
        end
      end
    end
  end
end
