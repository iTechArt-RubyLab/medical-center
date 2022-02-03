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
          patient.allergies = Allergy.find(params[:allergies]) if params[:allergies].present?
          patient.save
          redirect "#{patients_crud_url}/#{patient.id}"
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
            checked_allergies = Allergy.find(params[:allergies]) if params[:allergies].present?
            patient.update(params.merge(allergies: checked_allergies))
            present patient, with: Entities::Patient
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
