module V1
  module Admin
    class SickLeaves < API
      desc 'create a new sick_leave'

      helpers do
        def sick_leave
          @sick_leave ||= SickLeave.find(params[:id])
        end
      end

      resources :sick_leaves do
        desc 'Return all sick_leaves'
        get do
          sick_leaves = SickLeave.all
        end

        desc 'Return specific sick_leave'
        route_param :id, type: Integer do
          get { sick_leave }
        end

        post do
          SickLeave.create!(params)
        end

        desc 'Update a specific sick_leave'
        route_param :id do
          put do
            @sick_leave = sick_leave

            if @sick_leave.update(params)
              sick_leave
            else
              error!({ error_message: @sick_leave.errors.full_messages.join(', ') }, 422)
            end
          end
        end

        desc 'Delete a specific sick_leave'
        route_param :id do
          delete do
            @sick_leave = sick_leave
            if @sick_leave.destroy
              @sick_leave
            else
              error!({ error_message: @sick_leave.errors.full_messages.join(', ') }, 422)
            end
          end
        end
      end
    end
  end
end