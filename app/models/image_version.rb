class ImageVersion < ActiveRecord::Base
  attr_accessible :page_id, :image, :width, :height

  before_save :update_image_attributes

  belongs_to :page

  has_many :annotations, :dependent => :destroy

  mount_uploader :image, ImageUploader

private

  def update_image_attributes
    if image.present?
      self.width, self.height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      logger.debug "update_image_attributes: #{self.width} x #{self.height}"
    end
  end
end
