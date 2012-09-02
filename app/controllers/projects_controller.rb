class ProjectsController < ApplicationController

  before_filter :authenticate_user!

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
