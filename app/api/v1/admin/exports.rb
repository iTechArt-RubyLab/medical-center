module V1
  module Admin
    class Exports < API
      helpers do
        def visit
          Visit.find(params[:id])
        end
      end

      get :export_visits do
        ExportVisits.perform_async(params)

        { status: :ok }
      end
    end
  end
end
