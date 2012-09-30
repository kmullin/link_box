class AddOriginalFilenameAndWebDirToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :original_filename, :string

    add_column :assets, :web_dir, :string

  end
end
