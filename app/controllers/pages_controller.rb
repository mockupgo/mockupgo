class PagesController < ApplicationController

  def create
    @project = current_user.projects.find_by_id(params[:project_id])
    @page = @project.pages.build(params[:page])

    @page.save

    redirect_to project_path(@project)
  end


  def show
    @projects = current_user.projects.all
    @project = current_user.projects.find_by_id(params[:project_id])
    @page = @project.pages.find_by_id(params[:id])
    puts @page.inspect
  end


  def destroy
    @project = current_user.projects.find_by_id(params[:project_id])
    @page = @project.pages.find_by_id(params[:id])
    
    @page.destroy
    
    flash[:notice] = "The page has been deleted"
    
    redirect_to project_path(@project)
  end

end
