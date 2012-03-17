class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :path
      t.string :filename
      t.integer :size
      t.string :content_type
      t.text :description
      t.text :notes

      t.timestamps
    end
  end
end
