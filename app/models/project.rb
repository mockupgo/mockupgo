# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  attr_accessible :name, :user_id

  validates :name, :presence => true

  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'

  has_many :pages, dependent: :destroy

end
