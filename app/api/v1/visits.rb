module V1
  class Visits < API
    desc 'create a new visit'
    # params do
    #   requires :cabinet, type: String
    #   requires :notes, type: String
    #   requires :date, type: String
    #   requires :diagnosis_ids, type: Array
    # end

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
    # rubocop:disable Metrics/BlockLength
    resources :visits do
      post do
        visit = Visit.new(params)
        visit.user = current_user

        if visit.save
          present visit
        else
          error!({ error_message: visit.errors.full_messages.join(', ') }, 422)
        end
      end

      desc 'Update a specific visit'
      route_param :id do
        put do
          visit = find_visit_by_id(params[:id])

          if visit.update(params)
            present visit
          else
            error!({ error_message: visit.errors.full_messages.join(', ') }, 422)
          end
        end
      end

      desc 'Return all visits'
      get do
        @visits = current_user_visits
        present @visits
      end

      desc 'Return specific visit'
      route_param :id, type: Integer do
        get do
          find_visit_by_id(params[:id])
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
