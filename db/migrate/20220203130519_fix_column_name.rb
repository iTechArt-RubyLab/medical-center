class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :visits, :visit_id_id, :visit_id
  end
end
