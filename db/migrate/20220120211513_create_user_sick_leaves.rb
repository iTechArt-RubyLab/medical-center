class CreateUserSickLeaves < ActiveRecord::Migration[6.1]
  def change
    create_table :user_sick_leaves do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sick_leave, null: false, foreign_key: true

      t.timestamps
    end
  end
end
