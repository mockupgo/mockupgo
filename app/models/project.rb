class Project < ActiveRecord::Base
  attr_accessible :name, :user_id

  validates :name, :presence => true

  belongs_to :user
  has_many :pages

end
