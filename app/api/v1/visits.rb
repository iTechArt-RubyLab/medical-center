module V1
  class Visits < API
    desc 'create a new visit'

    helpers do
      def current_user_visits
        Visit.where(user_id: current_user.id)
      end

      def find_visit_by_id(id)
        current_user_visits.find(id)
      end
    end

    resources :visits do
      post do
        current_user.visits.create!(params)
      end

      desc 'Update a specific visit'
      route_param :id do
        put do
          visit = find_visit_by_id(params[:id])

          visit.tap do |visit|
            visit.update!(params)
          end
        end
      end

      desc 'Return all visits'
      get do
        present current_user_visits
      end

      desc 'Return specific visit'
      route_param :id, type: Integer do
        get do
          find_visit_by_id(params[:id])
        end
      end
    end
  end
end
