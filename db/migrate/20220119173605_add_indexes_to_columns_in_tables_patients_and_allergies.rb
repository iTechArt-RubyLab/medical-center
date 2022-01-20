class AddIndexesToColumnsInTablesPatientsAndAllergies < ActiveRecord::Migration[6.1]
  def change
    add_index(:patients, [:email, :passport_id], unique: true)
    add_index(:allergies, :name, unique: true)
  end
end
