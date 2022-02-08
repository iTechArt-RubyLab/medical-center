module V1
  class Categories < API
    helpers Helpers::CrudHelpers

    resources :categories do
      desc 'Return all categories'
      params do
        optional :sort, type: Hash
      end
      get do
        default_sort = { column_name: 'title', type: 'asc' }
        present sorting(Category, declared(params)[:sort], default_sort), with: Entities::Category
      end

      desc 'Return a specific category'
      route_param :id do
        get do
          category = Category.find(params[:id])
          present category, with: Entities::Category
        end
      end
    end
  end
end
