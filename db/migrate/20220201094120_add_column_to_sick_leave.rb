class AddColumnToSickLeave < ActiveRecord::Migration[6.1]
  def change
    add_column :sick_leaves, :place, :text
    remove_column :sick_leaves, :user_id
    remove_column :sick_leaves, :patient_id
  end
end
