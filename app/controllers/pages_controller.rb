class PagesController < ApplicationController

  before_filter :get_all_projects

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

  end


  def show
    
    @project = current_user.projects.find_by_id(params[:project_id])
    @page = @project.pages.find_by_id(params[:id])
  end

  def edit
    @project = current_user.projects.find_by_id(params[:project_id])
    @page = @project.pages.find_by_id(params[:id])
  end

  def update
    @project = current_user.projects.find_by_id(params[:project_id])
    @page = @project.pages.find_by_id(params[:id])

    if @page.update_attributes(params[:page])
      redirect_to [@project, @page], notice: "Successfully updated data."
    else
      render :edit
    end
  end

  def destroy
    @project = current_user.projects.find_by_id(params[:project_id])
    @page = @project.pages.find_by_id(params[:id])
    
    @page.destroy
    
    flash[:notice] = "The page has been deleted"
    
    redirect_to project_path(@project)
  end



  def get_all_projects
    @projects = current_user.projects.all
  end

end
