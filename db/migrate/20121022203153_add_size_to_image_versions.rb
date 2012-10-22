class AddSizeToImageVersions < ActiveRecord::Migration
  def change
    add_column :image_versions, :width, :integer
    add_column :image_versions, :height, :integer
  end
end
