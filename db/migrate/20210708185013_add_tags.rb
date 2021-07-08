class AddTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :word, null: false
      t.string :tag, null: false
      t.timestamps default: -> { 'NOW()' }

      t.index [:word, :tag], unique: true
      t.index :tag
    end

    add_foreign_key :tags, :words, column: :word, primary_key: :word, on_delete: :cascade
  end
end
