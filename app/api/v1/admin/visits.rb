module V1
  module Admin
    class Visits < API
      desc 'create a new visit'
      # params do
      #   requires :cabinet, type: String
      #   requires :notes, type: String
      #   requires :date, type: String
      # end

      helpers do
        def visit
          @visit ||= Visit.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          error!({ error_messages: e.message }, 422)
        end
      end
      # rubocop:disable Metrics/BlockLength
      resources :visits do
        desc 'Return all visits'
        get do
          @visits = Visit.all
          present @visits
        end

        desc 'Return specific visit'
        route_param :id, type: Integer do
          get do
            visit
          end
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
            if visit.destroy
              present visit
            else
              error!({ error_message: visit.errors.full_messages.join(', ') }, 500)
            end
          end
        end
      end
      # rubocop:enable Metrics/BlockLength
    end
  end
end
