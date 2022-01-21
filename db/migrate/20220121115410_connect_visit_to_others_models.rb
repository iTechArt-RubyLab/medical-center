class ConnectVisitToOthersModels < ActiveRecord::Migration[6.1]
  def change
    remove_column :visits, :birthday
    remove_column :visits, :doctor_id
    remove_column :visits, :patient_id
    remove_column :visits, :sick_leave_id
    add_reference :visits, :user, null: false, foreign_key: true
    add_reference :visits, :patient, null: false, foreign_key: true
    add_reference :visits, :sick_leave, null: false, foreign_key: true
  end
end
