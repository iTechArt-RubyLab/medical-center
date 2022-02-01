class ChangeColumnSickLeaveIdToVisits < ActiveRecord::Migration[6.1]
  def change
    change_column_null :visits, :sick_leave_id, true
  end
end
