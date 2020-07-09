class AddIndexToUrls < ActiveRecord::Migration[6.0]
  def change
    add_index :urls, :slug, unique: true
  end
end
