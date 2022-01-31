module V1
  module Admin
    class Categories < API
      resources :categories do
        desc 'Return all categories'
        get do
          categories = Category.all
          present categories, with: Entities::Category
        end

        desc 'Return a specific category'
        route_param :id do
          get do
            category = Category.find(params[:id])
            present category, with: Entities::Category
          rescue ActiveRecord::RecordNotFound
            error!({ error_code: 404, error_message: 'Category not found' })
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
          else
            error!({ error_code: 400, error_message: category.errors.full_messages.to_sentence })
          end
        end

        desc 'Update an existing category'
        route_param :id do
          put do
            begin
              category = Category.find(params[:id])
            rescue ActiveRecord::RecordNotFound
              error!({ error_code: 404, error_message: 'Category not found' })
            end
            if category.update(
              title: params[:title],
              description: params[:description]
            )
              present category, with: Entities::Category
            else
              error!({ error_code: 400, error_message: category.errors.full_messages.to_sentence })
            end
          end
        end

        desc 'Delete category'
        params do
          requires :id
        end
        delete do
          begin
            category = Category.find(params[:id])
          rescue ActiveRecord::RecordNotFound
            error!({ error_code: 404, error_message: 'Category not found' })
          end
          begin
            category.destroy!
            redirect '/api/v1/admin/categories'
          rescue StandardError
            error!({ error_code: 500, error_message: 'Something went wrong while deleting a category' })
          end
        end
      end
    end
  end
end
