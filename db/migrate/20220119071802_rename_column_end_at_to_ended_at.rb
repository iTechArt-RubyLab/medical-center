class RenameColumnEndAtToEndedAt < ActiveRecord::Migration[6.1]
  def change
    rename_column :sick_leaves, :end_at, :ended_at
  end
end
