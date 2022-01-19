class CreatePatientAllergies < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_allergies do |t|
      t.references :patient, null: false, foreign_key: true, index: true
      t.references :allergy, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
