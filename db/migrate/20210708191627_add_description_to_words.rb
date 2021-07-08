class AddDescriptionToWords < ActiveRecord::Migration[6.1]
  def change
    add_column :words, :description, :string, limit: 2.kilobytes
  end
end
