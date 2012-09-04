
class StaticPagesController < ApplicationController

  before_filter :authenticate_user!, only: [:dashboard]


  def home
    if user_signed_in?
      redirect_to dashboard_path
    else
      redirect_to new_user_session_path
    end
  end

  def help
  end

  def dashboard
    @projects = current_user.projects
  end

end
