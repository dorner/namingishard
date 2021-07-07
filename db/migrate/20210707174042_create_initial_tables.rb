class CreateInitialTables < ActiveRecord::Migration[6.1]
  def change
    create_table :words, id: false, primary_key: :word do |t|
      t.string :word, null: false
      t.timestamps default: -> { 'NOW()' }
      t.index :word, unique: true
    end

    create_table :word_relations do |t|
      t.string :word1, null: false
      t.string :word2, null: false
      t.integer :up_votes, null: false, default: 0
      t.integer :down_votes, null: false, default: 0
      t.timestamps default: -> { 'NOW()' }
      t.index [:word1, :word2], unique: true
    end

    add_foreign_key :word_relations, :words, column: :word1, primary_key: :word, on_delete: :cascade
    add_foreign_key :word_relations, :words, column: :word2, primary_key: :word, on_delete: :cascade

  end
end
