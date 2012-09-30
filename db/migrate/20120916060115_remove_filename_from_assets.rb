class RemoveFilenameFromAssets < ActiveRecord::Migration
  def up
    remove_column :assets, :filename
  end

  def down
    add_column :assets, :filename, :string
  end
end
