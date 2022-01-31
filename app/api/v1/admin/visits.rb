module V1
  module Admin
    class Visits < API
      desc 'create a new visit'

      helpers do
        def visit
          @visit ||= Visit.find(params[:id])
        end
      end

      resources :visits do
        desc 'Return all visits'
        get do
          visits = Visit.all
          present visits
        end

        desc 'Return specific visit'
        route_param :id, type: Integer do
          get { visit }
        end

        post do
          Visit.create!(params)
        end

        desc 'Update a specific visit'
        route_param :id do
          put do
            @visit = visit

            if @visit.update(params)
              present @visit
            else
              error!({ error_message: @visit.errors.full_messages.join(', ') }, 422)
            end
          end
        end

        desc 'Delete a specific visit'
        route_param :id do
          delete do
            @visit = visit
            if @visit.destroy
              present @visit
            else
              error!({ error_message: @visit.errors.full_messages.join(', ') }, 422)
            end
          end
        end
      end
    end
  end
end
