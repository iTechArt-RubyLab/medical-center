class RemoveColumnFromSickLeave < ActiveRecord::Migration[6.1]
  def change
    remove_column :sick_leaves, :place, :text
  end
end
