class CreateImageMockups < ActiveRecord::Migration
  def change
    create_table :image_mockups do |t|
      t.integer :page_id
      t.string  :image

      t.timestamps
    end
  end
end
