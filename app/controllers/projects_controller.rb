class ProjectsController < ApplicationController

	def create
		project = current_user.projects.build(params[:project])

    project.save

		redirect_to dashboard_path
	end
end
