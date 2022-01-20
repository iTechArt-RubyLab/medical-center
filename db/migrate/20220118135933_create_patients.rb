class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :full_name, null: false
      t.string :email
      t.string :telephone_number
      t.datetime :date_of_birth
      t.text :allergies_additional
      t.text :notes
      t.string :passport_id
      t.string :address

      t.timestamps null: false
    end
  end
end
