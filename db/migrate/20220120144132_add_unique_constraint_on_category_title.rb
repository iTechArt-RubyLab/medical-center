class AddUniqueConstraintOnCategoryTitle < ActiveRecord::Migration[6.1]
  def change
    add_index :categories, :title, unique: true
  end
end
