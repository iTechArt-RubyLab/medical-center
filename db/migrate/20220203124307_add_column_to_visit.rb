class AddColumnToVisit < ActiveRecord::Migration[6.1]
  def change
    add_reference(:visits, :visit_id, foreign_key: { to_table: :visits })
  end
end
