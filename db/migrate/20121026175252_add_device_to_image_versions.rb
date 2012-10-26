class AddDeviceToImageVersions < ActiveRecord::Migration
  def change
    add_column :image_versions, :device, :string
  end
end
