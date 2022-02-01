module V1
  class SickLeaves < API

    helpers do
      def current_user_sickleave
        SickLeave.where(user_id: current_user.id)
      end

      def find_sickleave_by_id(id)
        current_user_sickleave.find(id)
      rescue ActiveRecord::RecordNotFound => e
        error!({ error_messages: e.message }, 422)
      end
    end

    resources :sick_leaves do
      post do
        
        binding.pry
        
        current_user.sick_leaves.create!(params)
      end

      desc 'Update a specific sickleave'
      route_param :id do
        put do
          sick_leave = find_sickleave_by_id(params[:id])

          if sick_leave.update(params)
            present sick_leave
          else
            error!({ error_message: sick_leave.errors.full_messages.join(', ') }, 422)
          end
        end
      end

      desc 'Return all sickleaves'
      get do
        @sick_leaves = current_user_sickleave
        present @sick_leaves
      end

      desc 'Return specific sickleave'
      route_param :id, type: Integer do
        get do
          find_sickleave_by_id(params[:id])
        end
      end
    end
  end
end