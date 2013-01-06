class RenameColumnImageVersionsIdInReviews < ActiveRecord::Migration
  def up
    rename_column :reviews, :image_versions_id, :image_version_id
  end

  def down
    rename_column :reviews, :image_version_id, :image_versions_id
  end
end
