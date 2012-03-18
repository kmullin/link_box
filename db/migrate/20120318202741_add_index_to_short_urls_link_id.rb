class AddIndexToShortUrlsLinkId < ActiveRecord::Migration
  def change
    add_index :short_urls, :link_id, :unique => true
  end
end
