class CreateDiagnoses < ActiveRecord::Migration[6.1]
  def change
    create_table :diagnoses do |t|
      t.string :name, null: false
      t.string :symptom, null: false
      t.text :medication_list, null: false

      t.timestamps
    end
  end
end
