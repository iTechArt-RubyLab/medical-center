module V1
  class SickLeaves < API
    helpers do
      def sick_leave
        SickLeave.find(params[:id])
      end
    end

    resources :sick_leaves do
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
          sick_leave.tap do |sick_leave|
            sick_leave.update!(declared(params, include_missing: false))
          end
        end
      end

      desc 'Return all sick_leaves'
      get do
        SickLeave.all
      end

      desc 'Return specific sick_leave'
      route_param :id, type: Integer do
        get { sick_leave }
      end
    end
  end
end