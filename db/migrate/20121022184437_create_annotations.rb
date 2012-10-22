class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.integer :image_version_id
      t.string :comment
      t.integer :height
      t.integer :width
      t.integer :left
      t.integer :top

      t.timestamps
    end
  end
end
