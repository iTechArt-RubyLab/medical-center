class AddIndexesToColumnsInTablesPatientsAndAllergies < ActiveRecord::Migration[6.1]
  def change
    add_index(:patients, :email)
    add_index(:patients, :passport_id)
    add_index(:allergies, :name)
  end
end
