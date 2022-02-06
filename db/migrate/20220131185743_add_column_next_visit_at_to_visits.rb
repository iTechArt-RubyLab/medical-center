class AddColumnNextVisitAtToVisits < ActiveRecord::Migration[6.1]
  def change
    add_column :visits, :next_visit_at, :datetime
  end
end
