class AddUniqueConstraint < ActiveRecord::Migration[6.1]
  def change
    add_index :diagnoses, :name, unique: true
  end
end
