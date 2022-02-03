class RemoveColumnFromVisits < ActiveRecord::Migration[6.1]
  def change
    remove_column :visits, :next_visit_at, :datetime
  end
end
