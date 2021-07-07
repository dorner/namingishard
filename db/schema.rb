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

ActiveRecord::Schema.define(version: 2021_07_07_215910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "word_relations", force: :cascade do |t|
    t.string "word1", null: false
    t.string "word2", null: false
    t.integer "up_votes", default: 0, null: false
    t.integer "down_votes", default: 0, null: false
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.index ["word1", "word2"], name: "index_word_relations_on_word1_and_word2", unique: true
  end

  create_table "words", id: false, force: :cascade do |t|
    t.string "word", null: false
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.index ["word"], name: "index_words_on_word", unique: true
  end

  add_foreign_key "word_relations", "words", column: "word1", primary_key: "word", on_delete: :cascade
  add_foreign_key "word_relations", "words", column: "word2", primary_key: "word", on_delete: :cascade
end
