class CreatePatientSickLeaves < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_sick_leaves do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :sick_leave, null: false, foreign_key: true

      t.timestamps
    end
  end
end
