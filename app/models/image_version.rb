class ImageVersion < ActiveRecord::Base
  attr_accessible :page_id, :image

  belongs_to :page

  mount_uploader :image, ImageUploader

end
