class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  def show
    @project = current_user.projects.find_by_id(params[:id])

    unless @project
      redirect_to dashboard_path, alert: "You can't access this project."
    end

  end


	def create
		project = current_user.projects.build(params[:project])

    if project.save
      flash[:notice] = 'Project created successfully.'
    else
      flash[:notice] = 'Project failed to save.'
      flash[:error]  = project.errors.full_messages
    end

		redirect_to dashboard_path
	end
end
