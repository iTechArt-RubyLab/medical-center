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
          end
        end

        desc 'Create a new patient'
        params do
          requires :address, :date_of_birth, :email, :full_name, :notes, :telephone_number,
                   :passport_id, :allergies_additional, :allergies
        end
        post do
          patient = Patient.create(params.except(:allergies))
          params[:allergies].split(/,/).each do |allergy_id|
            patient.allergies << Allergy.find(allergy_id)
          rescue ActiveRecord::RecordNotFound
            error!({ error_code: 400, error_message: 'Invalid data of allergies' }, 400)
          end
          if patient.valid?
            patient.save
            redirect "#{patients_crud_url}/#{patient.id}"
          else
            error!({ error_code: 400, error_message: patient.errors.full_messages.to_sentence }, 400)
          end
        end

        desc 'Update an existing patient'
        route_param :id do
          params do
            requires :address, :date_of_birth, :email, :full_name, :notes, :telephone_number,
                     :passport_id, :allergies_additional, :allergies
          end
          put do
            patient = Patient.find(params[:id])
            checked_allergies = []
            params[:allergies]&.split(/,/)&.each do |allergy_id|
              checked_allergies << Allergy.find(allergy_id)
            rescue ActiveRecord::RecordNotFound
              error!({ error_code: 400, error_message: 'Invalid data of allergies' }, 400)
            end
            if patient.update(params.merge(allergies: checked_allergies))
              present patient, with: Entities::Patient
            else
              error!({ error_code: 400, error_message: patient.errors.full_messages.to_sentence }, 400)
            end
          end
        end

        desc 'Delete patient'
        params do
          requires :id
        end
        delete do
          patient = Patient.find(params[:id])
          patient.destroy!
          redirect patients_crud_url
        end
      end
    end
  end
end
