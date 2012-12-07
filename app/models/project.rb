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
  attr_accessible :name, :user_id, :projects_users, :collaborators, :owner

  validates :name, :presence => true

  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'

  has_many :projects_users
  has_many :collaborators, :through => :projects_users, :source => :user


  # during migration => add project owner in collaborators list ?


  # https://github.com/gitlabhq/gitlabhq/blob/master/app/models/project.rb
  # belongs_to :owner, class_name: "User"
  # has_many :users, through: :users_projects
  # has_many :collaborators, through: :roles
  # users_projects could be "role" table ?
  # fail is email don't exist for user
  # when creating a project, link the owner to the project BOTH through the :role table and as :owner attribute
  # role needs to have a "type" attributes: "owner", "contributor"


  # only "owner" can delete project
  # only "owner" can invite new "contributor"


  # "Owner" is also a contributor !!! no need to specify the type of contributor yet !!! just check for owner in case of delete


  # in dashboard, list all the project you are connected to through "role" table, order alpha
  # current_user.users_projects.each do |project|

  # in controller, check that the user is connected through "role"
  # def allow_read_for?(user)
  #   !users_projects.where(user_id: user.id).empty?
  # end

  # when creating a new project:
  # project.owner = user
  # project.users_projects.create!(project_access: UsersProject::MASTER, user: user)
  # => project.users_projects.create!(user: user)

  # when adding somebody as a contributor: "grant access"
  # users_project = UsersProject.new(
  #   project_access: project_access,
  #   user_id: user_id
  # )
  # users_project.project = project
  # users_project.save


  has_many :pages, dependent: :destroy

  validates :owner, presence: true

end
