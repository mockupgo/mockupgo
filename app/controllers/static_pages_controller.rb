
class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def dashboard
  	@projects = current_user.projects
  end

end
