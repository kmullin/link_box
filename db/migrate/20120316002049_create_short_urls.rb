class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :link_id
      t.references :asset

      t.timestamps
    end
    add_index :short_urls, :asset_id
  end
end
