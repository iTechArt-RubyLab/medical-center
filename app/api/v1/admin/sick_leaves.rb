module V1
  module Admin
    class SickLeaves < API
      desc 'create a new sick_leave'

      helpers do
        def sick_leave
          @sick_leave = SickLeave.find(params[:id])
        end
      end

      resources :sick_leaves do
        desc 'Delete a specific sick_leave'
        route_param :id do
          delete do
            @sick_leave = sick_leave
            @sick_leave.destroy
            @sick_leave
          end
        end
      end
    end
  end
end
