class EnableTrigrams < ActiveRecord::Migration[6.1]
  def change
    ApplicationRecord.connection.execute('CREATE EXTENSION pg_trgm')
  end
end
