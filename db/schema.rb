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

ActiveRecord::Schema.define(version: 2020_04_13_031247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "belongs_to_objects", force: :cascade do |t|
    t.string "attribute_three"
    t.string "attribute_four"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "has_many_objects", force: :cascade do |t|
    t.integer "test_object_id"
    t.string "attribute_five"
    t.string "attribute_six"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_object_id"], name: "index_has_many_objects_on_test_object_id"
  end

  create_table "test_objects", force: :cascade do |t|
    t.string "attribute_one"
    t.string "attribute_two"
    t.integer "belongs_to_object_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["belongs_to_object_id"], name: "index_test_objects_on_belongs_to_object_id"
  end

end
