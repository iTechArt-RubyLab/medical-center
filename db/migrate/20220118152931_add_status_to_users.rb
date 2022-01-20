class AddStatusToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :status, :string
    add_index :users, :status
  end
end
