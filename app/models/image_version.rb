class ImageVersion < ActiveRecord::Base
  attr_accessible :page_id, :image, :width, :height

  belongs_to :page

  has_many :annotations, :dependent => :destroy

  mount_uploader :image, ImageUploader

  before_save :detect_device_type


  private

  def detect_device_type
    if image.present?
      # if self.width > 1024
      #   self.device = "desktop"
      # elsif self.width == 1024
      #   self.device = "ipad-landscape"
      # elsif self.width == 768
      #   self.device = "ipad-portrait"
      # elsif self.width == 480
      #   self.device = "iphone-landscape"
      if self.width == 320
        self.device = "iphone-portrait"
      else
        self.device = "desktop"
      end
    end
  end

end
