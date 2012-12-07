class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  before_filter :get_all_projects


  def show
    @project = current_user.projects.find_by_id(params[:id])
    @projects = current_user.projects
    
    unless @project
      redirect_to dashboard_path, alert: "You can't access this project."
    end

  end


	def create
 		project = Project.new(params[:project])
    project.owner = current_user
    project.collaborators << current_user

    if project.save
      flash[:notice] = 'Project created successfully.'
    else
      flash[:notice] = 'Project failed to save.'
      flash[:error]  = project.errors.full_messages
    end

		redirect_to dashboard_path
	end


  def edit
    @project = current_user.projects.find_by_id(params[:id])
  end

  def update
    @project = current_user.projects.find_by_id(params[:id])

    if @project.update_attributes(params[:project])
      redirect_to @project, notice: "Successfully updated data."
    else
      render :edit
    end
  end


  def destroy
    @project = current_user.projects.find_by_id(params[:id])
    @project.destroy
    redirect_to dashboard_path
  end

  def get_all_projects
    @projects = current_user.projects.all
  end

end
