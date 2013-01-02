class AddDeviceToPages < ActiveRecord::Migration
  def change
    add_column :pages, :device, :string
  end
end
