class CreateSickLeaves < ActiveRecord::Migration[6.1]
  def change
    create_table :sick_leaves do |t|
      t.string :destination
      t.integer :doctor_id, null: false
      t.integer :patient_id, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false

      t.timestamps
    end
  end
end
