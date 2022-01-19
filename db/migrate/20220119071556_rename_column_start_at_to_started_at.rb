class RenameColumnStartAtToStartedAt < ActiveRecord::Migration[6.1]
  def change
    rename_column :sick_leaves, :start_at, :started_at
  end
end
