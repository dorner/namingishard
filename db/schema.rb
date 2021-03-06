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

ActiveRecord::Schema.define(version: 2021_07_09_131643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "tags", force: :cascade do |t|
    t.string "word", null: false
    t.string "tag", null: false
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.index ["tag"], name: "index_tags_on_tag"
    t.index ["word", "tag"], name: "index_tags_on_word_and_tag", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.boolean "guest", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "word_relation_id"
    t.integer "user_id"
    t.integer "score"
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.index ["user_id"], name: "index_votes_on_user_id"
    t.index ["word_relation_id"], name: "index_votes_on_word_relation_id"
  end

  create_table "word_relations", force: :cascade do |t|
    t.string "word1", null: false
    t.string "word2", null: false
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.index ["word1", "word2"], name: "index_word_relations_on_word1_and_word2", unique: true
  end

  create_table "words", id: false, force: :cascade do |t|
    t.string "word", null: false
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.string "description", limit: 2048
    t.index ["word"], name: "index_words_on_word", unique: true
    t.index ["word"], name: "word_idx", opclass: :gin_trgm_ops, using: :gin
  end

  add_foreign_key "tags", "words", column: "word", primary_key: "word", on_delete: :cascade
  add_foreign_key "votes", "users"
  add_foreign_key "votes", "word_relations"
  add_foreign_key "word_relations", "words", column: "word1", primary_key: "word", on_delete: :cascade
  add_foreign_key "word_relations", "words", column: "word2", primary_key: "word", on_delete: :cascade
end
