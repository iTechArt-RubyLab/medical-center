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
          allergy = Allergy.create(declared(params))
          allergy.save!
          redirect "#{allergies_crud_url}/#{allergy.id}"
        end

        desc 'Update an existing allergy'
        route_param :id do
          params do
            requires :name
          end
          put do
            allergy = Allergy.find(params[:id])
            present allergy, with: Entities::Allergy if allergy.update!(declared(params))
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
