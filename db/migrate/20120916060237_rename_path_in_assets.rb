class RenamePathInAssets < ActiveRecord::Migration
  def up
    rename_column :assets, :path, :filename
  end

  def down
    rename_column :assets, :filename, :path
  end
end
