class AddOldidToAnnotations < ActiveRecord::Migration
  def change
    add_column :annotations, :oldid, :integer
  end
end
