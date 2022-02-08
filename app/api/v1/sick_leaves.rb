module V1
  class SickLeaves < API
    helpers Helpers::CrudHelpers
    helpers do
      def sick_leave
        SickLeave.find(params[:id])
      end
    end

    resources :sick_leaves do
      desc 'create a new sick_leave'
      params do
        requires :destination, type: String
        requires :started_at, type: String
        requires :ended_at, type: String
      end
      post do
        SickLeave.create!(declared(params, include_missing: true))
      end

      desc 'Update a specific sick_leave'
      route_param :id do
        params do
          optional :destination, type: String
          optional :started_at, type: String
          optional :ended_at, type: String
        end
        put do
          @sick_leave = sick_leave
          if @sick_leave.update(declared(params, include_missing: false))
            @sick_leave
          else
            error!({ error_message: @sick_leave.errors.full_messages.join(', ') }, 422)
          end
        end
      end

      desc 'Return all sick_leaves'
      params do
        optional :sort, type: Hash
      end
      get do
        default_sort = { column_name: 'id', type: 'asc' }
        present sorting(SickLeave, declared(params)[:sort], default_sort)
      end

      desc 'Return specific sick_leave'
      route_param :id, type: Integer do
        get { sick_leave }
      end
    end
  end
end
