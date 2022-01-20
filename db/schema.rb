# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_20_113202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diagnoses", force: :cascade do |t|
    t.string "name", null: false
    t.string "symptom", null: false
    t.text "medication_list", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_diagnoses_on_name", unique: true
  end

  create_table "sick_leaves", force: :cascade do |t|
    t.string "destination"
    t.integer "doctor_id", null: false
    t.integer "patient_id", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "visits", force: :cascade do |t|
    t.string "cabinet", null: false
    t.integer "doctor_id", null: false
    t.integer "patient_id", null: false
    t.datetime "date", null: false
    t.datetime "birthday", null: false
    t.text "notes"
    t.bigint "sick_leave_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sick_leave_id"], name: "index_visits_on_sick_leave_id"
  end

  create_table "visits_diagnoses", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "diagnose_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diagnose_id"], name: "index_visits_diagnoses_on_diagnose_id"
    t.index ["visit_id"], name: "index_visits_diagnoses_on_visit_id"
  end

  create_table "allergies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_allergies_on_name", unique: true
  end

  create_table "patient_allergies", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "allergy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["allergy_id"], name: "index_patient_allergies_on_allergy_id"
    t.index ["patient_id"], name: "index_patient_allergies_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email"
    t.string "telephone_number"
    t.datetime "date_of_birth"
    t.text "allergies_additional"
    t.text "notes"
    t.string "passport_id"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_patients_on_email", unique: true
    t.index ["passport_id"], name: "index_patients_on_passport_id", unique: true
  end

  add_foreign_key "visits", "sick_leaves", column: "sick_leave_id"
  add_foreign_key "patient_allergies", "allergies"
  add_foreign_key "patient_allergies", "patients"
end
