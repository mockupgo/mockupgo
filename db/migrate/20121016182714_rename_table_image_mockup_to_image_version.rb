class RenameTableImageMockupToImageVersion < ActiveRecord::Migration
  def up
    rename_table :image_mockups, :image_versions
  end

  def down
    rename_table :image_versions, :image_mockups
  end
end
