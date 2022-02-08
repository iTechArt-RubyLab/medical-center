module V1
  class Visits < API
    helpers Helpers::CrudHelpers
    helpers do
      def current_user_visits
        Visit.where(user_id: current_user.id)
      end

      def find_visit_by_id(id)
        current_user_visits.find(id)
      rescue ActiveRecord::RecordNotFound => e
        error!({ error_messages: e.message }, 422)
      end
    end

    resources :visits do
      desc 'create a new visit'
      post do
        current_user.visits.create!(params)
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
