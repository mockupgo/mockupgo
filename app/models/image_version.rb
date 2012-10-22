class ImageVersion < ActiveRecord::Base
  attr_accessible :page_id, :image, :width, :height

  belongs_to :page

  has_many :annotations, :dependent => :destroy

  mount_uploader :image, ImageUploader

end
