module Patients
  class API < Grape::API
    format :json
    prefix :api

    resources :patients do
      desc 'Return all patients'
      get do
        ::Patient.all
      end

      desc 'Show one patient'
      params do
        requires :id, desc: 'Patient id'
      end

      get ':id' do
        begin
          patient = Patient.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          error!({ status: :not_found }, 404)
        end
      end
    end
  end
end