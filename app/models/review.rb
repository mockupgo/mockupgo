class Review < ActiveRecord::Base
  attr_accessible :image_version_id, :user_id, :image_version

  belongs_to :image_version
  belongs_to :user

  # validates_uniqueness_of :image_version_id, :scope => :user_id

end


