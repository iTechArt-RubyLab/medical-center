class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :visits_diagnoses, :diagnose_id, :diagnosis_id
  end
end
