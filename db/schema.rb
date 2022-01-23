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

ActiveRecord::Schema.define(version: 2022_01_21_134450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "allergies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_allergies_on_name", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_categories_on_title", unique: true
  end

  create_table "diagnoses", force: :cascade do |t|
    t.string "name", null: false
    t.string "symptom", null: false
    t.text "medication_list", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_diagnoses_on_name", unique: true
  end

  create_table "patient_allergies", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "allergy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["allergy_id"], name: "index_patient_allergies_on_allergy_id"
    t.index ["patient_id"], name: "index_patient_allergies_on_patient_id"
  end

  create_table "patient_sick_leaves", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "sick_leave_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_patient_sick_leaves_on_patient_id"
    t.index ["sick_leave_id"], name: "index_patient_sick_leaves_on_sick_leave_id"
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

  create_table "sick_leaves", force: :cascade do |t|
    t.string "destination"
    t.datetime "started_at", null: false
    t.datetime "ended_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "patient_id", null: false
    t.index ["patient_id"], name: "index_sick_leaves_on_patient_id"
    t.index ["user_id"], name: "index_sick_leaves_on_user_id"
  end

  create_table "user_categories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "user_sick_leaves", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "sick_leave_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sick_leave_id"], name: "index_user_sick_leaves_on_sick_leave_id"
    t.index ["user_id"], name: "index_user_sick_leaves_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.integer "role", default: 0, null: false
    t.string "phone_number", null: false
    t.date "birthdate", null: false
    t.string "cabinet_number", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["status"], name: "index_users_on_status"
  end

  create_table "visits", force: :cascade do |t|
    t.string "cabinet", null: false
    t.datetime "date", null: false
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "patient_id", null: false
    t.bigint "sick_leave_id", null: false
    t.index ["patient_id"], name: "index_visits_on_patient_id"
    t.index ["sick_leave_id"], name: "index_visits_on_sick_leave_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

  create_table "visits_diagnoses", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "diagnose_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diagnose_id"], name: "index_visits_diagnoses_on_diagnose_id"
    t.index ["visit_id"], name: "index_visits_diagnoses_on_visit_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "patient_allergies", "allergies"
  add_foreign_key "patient_allergies", "patients"
  add_foreign_key "patient_sick_leaves", "patients"
  add_foreign_key "patient_sick_leaves", "sick_leaves", column: "sick_leave_id"
  add_foreign_key "sick_leaves", "patients"
  add_foreign_key "sick_leaves", "users"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_categories", "users"
  add_foreign_key "user_sick_leaves", "sick_leaves", column: "sick_leave_id"
  add_foreign_key "user_sick_leaves", "users"
  add_foreign_key "visits", "patients"
  add_foreign_key "visits", "sick_leaves", column: "sick_leave_id"
  add_foreign_key "visits", "users"
end
