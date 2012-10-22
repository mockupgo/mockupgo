class Annotation < ActiveRecord::Base
  attr_accessible :comment, :height, :image_version_id, :left, :top, :width

  belongs_to :image_version

end
