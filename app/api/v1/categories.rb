module V1
  class Categories < API
    resources :categories do
      desc 'Return all categories'
      params do
        optional :sort, type: Hash
      end
      get do
        present sorting(Category, declared(params)[:sort]).paginate(page: params[:page]), with: Entities::Category
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
