
class StaticPagesController < ApplicationController

  before_filter :authenticate_user!, only: [:dashboard]


  def home
  end

  def help
  end

  def dashboard
  	@projects = current_user.projects
  end

end
