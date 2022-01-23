class ChangeModelSickLeave < ActiveRecord::Migration[6.1]
  def change
    remove_column :sick_leaves, :doctor_id
    remove_column :sick_leaves, :patient_id
    add_reference :sick_leaves, :user, null: false, foreign_key: true
    add_reference :sick_leaves, :patient, null: false, foreign_key: true
  end
end
