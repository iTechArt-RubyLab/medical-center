module V1
  module Admin
    class Patients < API
      patients_crud_url = '/api/v1/admin/patients'
      resources :patients do
        desc 'Return all patients'
        get do
          patients = Patient.all
          present patients, with: Entities::Patient
        end

        desc 'Return a specific patient'
        route_param :id do
          get do
            patient = Patient.find(params[:id])
            present patient, with: Entities::Patient
          rescue ActiveRecord::RecordNotFound
            error!({ error_code: 404, error_message: 'Patient not found' })
          end
        end

        desc 'Create a new patient'
        params do
          requires :address, :date_of_birth, :email, :full_name, :notes, :telephone_number,
                   :passport_id, :allergies_additional, :allergies
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
            allergies_additional: params[:allergies_additional]
          )
          params[:allergies].split(/,/).each do |allergy_id|
            patient.allergies << Allergy.find(allergy_id)
          rescue ActiveRecord::RecordNotFound
            error!({ error_code: 400, error_message: 'Invalid data of allergies' })
          end
          if patient.valid?
            patient.save
            redirect "#{patients_crud_url}/#{patient.id}"
          else
            error!({ error_code: 400, error_message: patient.errors.full_messages.to_sentence })
          end
        end

        desc 'Update an existing patient'
        route_param :id do
          params do
            requires :address, :date_of_birth, :email, :full_name, :notes, :telephone_number,
                     :passport_id, :allergies_additional, :allergies
          end
          put do
            begin
              patient = Patient.find(params[:id])
            rescue ActiveRecord::RecordNotFound
              error!({ error_code: 404, error_message: 'Patient not found' })
            end
            checked_allergies = []
            params[:allergies]&.split(/,/)&.each do |allergy_id|
              checked_allergies << Allergy.find(allergy_id)
            rescue ActiveRecord::RecordNotFound
              error!({ error_code: 400, error_message: 'Invalid data of allergies' })
            end
            if patient.update(
              address: params[:address],
              date_of_birth: params[:date_of_birth],
              email: params[:email],
              full_name: params[:full_name],
              notes: params[:notes],
              telephone_number: params[:telephone_number],
              passport_id: params[:passport_id],
              allergies_additional: params[:allergies_additional],
              allergies: checked_allergies
            )
              present patient, with: Entities::Patient
            else
              error!({ error_code: 400, error_message: patient.errors.full_messages.to_sentence })
            end
          end
        end

        desc 'Delete patient'
        params do
          requires :id
        end
        delete do
          begin
            patient = Patient.find(params[:id])
          rescue ActiveRecord::RecordNotFound
            error!({ error_code: 404, error_message: 'Patient not found' })
          end
          begin
            patient.destroy!
            redirect patients_crud_url
            # rubocop:disable Style/RescueStandardError
          rescue
            # rubocop:enable Style/RescueStandardError
            error!({ error_code: 500, error_message: 'Something went wrong while deleting a patient' })
          end
        end
      end
    end
  end
end
