class PagesController < ApplicationController

  def create
    @project = current_user.projects.find_by_id(params[:project_id])

    @image = ImageVersion.create(params[:image_version])

    @page = @project.pages.build(name: PagesHelper.guess_name_from_filename(@image.image.identifier))
    @page.image_versions << @image

    @page.save

  respond_to do |format|
    format.html { redirect_to project_path(@project) }
    format.js
  end


    # redirect_to project_path(@project)
  end


  def show
    @projects = current_user.projects.all
    @project = current_user.projects.find_by_id(params[:project_id])
    @page = @project.pages.find_by_id(params[:id])
  end


  def destroy
    @project = current_user.projects.find_by_id(params[:project_id])
    @page = @project.pages.find_by_id(params[:id])
    
    @page.destroy
    
    flash[:notice] = "The page has been deleted"
    
    redirect_to project_path(@project)
  end

end
