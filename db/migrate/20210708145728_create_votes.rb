class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :word_relation_id
      t.integer :user_id
      t.integer :score
      t.timestamps default: -> { 'NOW()' }

      t.index :word_relation_id
      t.index :user_id
    end
    add_foreign_key :votes, :word_relations
    add_foreign_key :votes, :users

    remove_column :word_relations, :up_votes, :integer, default: 0, null: false
    remove_column :word_relations, :down_votes, :integer, default: 0, null: false

  end
end
