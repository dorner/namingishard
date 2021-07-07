class AddTrigramIndex < ActiveRecord::Migration[6.1]
  def change
    sql = <<-SQL
      create index word_idx on words using gin(word gin_trgm_ops)
    SQL
    ApplicationRecord.connection.execute(sql)
  end
end
