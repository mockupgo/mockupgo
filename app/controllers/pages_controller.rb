class PagesController < ApplicationController

  def create
    @project = current_user.projects.find_by_id(params[:project_id])
    @page = @project.pages.build(params[:page])

    @page.save

    redirect_to project_path(@project)
  end

end
