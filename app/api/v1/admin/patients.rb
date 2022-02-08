module V1
  module Admin
    class Patients < API
      patients_crud_url = '/api/v1/admin/patients'
      resources :patients do
        desc 'Return all patients'
        get do
          search = params['search'] || nil

          if search
            present Patient.search(params['search']), with: Entities::Patient
          else
            present Patient.all, with: Entities::Patient
          end
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
          requires :address, :date_of_birth, :full_name, :telephone_number, :passport_id
          optional :email, :notes, :allergies_additional, :allergies_ids
        end
        post do
          patient = Patient.create(declared(params, include_missing: true).except(:allergies_ids))
          patient.allergies = Allergy.find(params[:allergies_ids]) if params[:allergies_ids].present?
          patient.save!
          redirect "#{patients_crud_url}/#{patient.id}"
        end

        desc 'Update an existing patient'
        route_param :id do
          params do
            requires :address, :date_of_birth, :full_name, :telephone_number, :passport_id
            optional :email, :notes, :allergies_additional, :allergies_ids
          end
          put do
            patient = Patient.find(params[:id])
            checked_allergies = []
            checked_allergies = Allergy.find(params[:allergies_ids]) if params[:allergies_ids].present?
            patient.update!(
              declared(params, include_missing: true).except(:allergies_ids).merge(allergies: checked_allergies)
            )
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
