module V1
  module Admin
    class Categories < API
      resources :categories do
        desc 'Return all categories'
        get do
          categories = Category.all
          present categories, with: Entities::Category

          respond_to do |format|
            format.html
            format.pdf do
              render pdf: "Categories",
                     page_size: "A4",
                     template: "categories/category.pdf.erb"
            end
          end

        end

        desc 'Return a specific category'
        route_param :id do
          get do
            category = Category.find(params[:id])
            present category, with: Entities::Category
          end
        end

        desc 'Create a new category'
        params do
          requires :title, :description
        end
        post do
          category = Category.create(
            title: params[:title],
            description: params[:description]
          )
          if category.valid?
            category.save
            redirect "/api/v1/admin/categories/#{category.id}"
          end
        end

        desc 'Update an existing category'
        route_param :id do
          put do
            category = Category.find(params[:id])
            if category.update(
              title: params[:title],
              description: params[:description]
            )
              present category, with: Entities::Category
            end
          end
        end

        desc 'Delete category'
        params do
          requires :id
        end
        delete do
          category = Category.find(params[:id])
          category.destroy!
          redirect '/api/v1/admin/categories'
        end
      end
    end
  end
end
