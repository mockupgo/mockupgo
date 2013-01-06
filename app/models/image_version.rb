class ImageVersion < ActiveRecord::Base
  attr_accessible :page_id, :image, :width, :height

  belongs_to :page

  has_many :annotations, :dependent => :destroy

  mount_uploader :image, ImageUploader

  before_save :detect_device_type

  has_many :reviews
  has_many :user_reviews, through: :reviews, :source => :user

  def reviewed_by?(user)
    user_reviews.where('user_id = ?', user.id).count > 0
  end

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
