class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits do |t|
      t.string :cabinet, null: false
      t.integer :doctor_id, null: false
      t.integer :patient_id, null: false
      t.datetime :date, null: false
      t.datetime :birthday, null: false
      t.text :notes

      t.belongs_to :sick_leave, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
