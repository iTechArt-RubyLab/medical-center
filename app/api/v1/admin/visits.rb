module V1
  module Admin
    class Visits < API
      helpers do
        def visit
          Visit.find(params[:id])
        end
      end

      resources :visits do
        desc 'Return all visits'
        params do
          optional :sort, type: Hash
        end
        get do
          present sorting(Visit, declared(params)[:sort]).paginate(page: params[:page])
        end

        desc 'Return specific visit'
        route_param :id, type: Integer do
          get { visit }
        end

        desc 'create a new visit'
        post do
          Visit.create!(params)
        end

        desc 'Update a specific visit'
        route_param :id do
          put do
            visit.tap { |visit| visit.update!(params) }
          end
        end

        desc 'Delete a specific visit'
        route_param :id do
          delete do
            visit.destroy!
          end
        end
      end
    end
  end
end
