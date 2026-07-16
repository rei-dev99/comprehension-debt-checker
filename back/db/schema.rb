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

ActiveRecord::Schema[8.1].define(version: 2026_07_08_115021) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_summaries", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.integer "max_score", null: false
    t.integer "min_score", null: false
    t.text "summary", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_summaries_on_category_id"
  end

  create_table "choices", force: :cascade do |t|
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.text "feedback", null: false
    t.bigint "question_id", null: false
    t.integer "score", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_questions_on_category_id"
  end

  create_table "results", force: :cascade do |t|
    t.text "advice", null: false
    t.integer "ai_score", null: false
    t.integer "algorithm_score", null: false
    t.datetime "created_at", null: false
    t.integer "db_score", null: false
    t.integer "dependency_score", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "web_score", null: false
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "user_credentials", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["provider", "uid"], name: "index_user_credentials_on_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_user_credentials_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "category_summaries", "categories"
  add_foreign_key "choices", "questions"
  add_foreign_key "questions", "categories"
  add_foreign_key "results", "users"
  add_foreign_key "user_credentials", "users"
end
