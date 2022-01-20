class CreateVisitsDiagnoses < ActiveRecord::Migration[6.1]
  def change
    create_table :visits_diagnoses do |t|
      t.belongs_to :visit
      t.belongs_to :diagnose

      t.timestamps
    end
  end
end
