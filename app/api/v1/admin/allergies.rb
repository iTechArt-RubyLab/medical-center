module V1
  module Admin
    class Allergies < API
      allergies_crud_url = '/api/v1/admin/allergies'
      resources :allergies do
        desc 'Return all allergies'
        get do
          allergies = Allergy.all
          present allergies, with: Entities::Allergy
        end

        desc 'Return a specific allergy'
        route_param :id do
          get do
            allergy = Allergy.find(params[:id])
            present allergy, with: Entities::Allergy
          end
        end

        desc 'Create a new allergy'
        params do
          requires :name
        end
        post do
          allergy = Allergy.create(params)
          if allergy.valid?
            allergy.save
            redirect allergy.id.to_s
          else
            error!({ error_code: 400, error_message: allergy.errors.full_messages.to_sentence })
          end
        end

        desc 'Update an existing allergy'
        route_param :id do
          params do
            requires :name
          end
          put do
            allergy = Allergy.find(params[:id])
            if allergy.update(name: params[:name])
              present allergy, with: Entities::Allergy
            else
              error!({ error_code: 400, error_message: allergy.errors.full_messages.to_sentence })
            end
          end
        end

        desc 'Delete allergy'
        params do
          requires :id
        end
        delete do
          allergy = Allergy.find(params[:id])
          allergy.destroy!
          redirect allergies_crud_url
        end
      end
    end
  end
end
