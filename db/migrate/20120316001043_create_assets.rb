class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.text :description
      t.text :notes
      t.string :file_name

      t.timestamps
    end
  end
end
