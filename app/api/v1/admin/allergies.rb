module V1
  module Admin
    class Allergies < API
      helpers Helpers::CrudHelpers

      allergies_crud_url = '/api/v1/admin/allergies'
      resources :allergies do
        desc 'Return all allergies'
        params do
          optional :sort, type: Hash
        end
        get do
          default_sort = { column_name: 'name', type: 'asc' }
          present sorting(Allergy, declared(params)[:sort], default_sort).paginate(page: params[:page]), with: Entities::Allergy
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
