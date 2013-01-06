# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base
  attr_accessible :name, :project_id, :image_versions, :device

  belongs_to :project

  has_many :image_versions, :dependent => :destroy

  def latest_version
    image_versions.last
  end


end
