class ProjectsUsersController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @email   = params[:email]

    @collaborator = User.find_by_email(@email)

    if @collaborator
      @project.collaborators << @collaborator
      @project.save
      flash[:notice] = "#{@collaborator.email} was added to this project."
    else
      flash[:error]  = "Could not add #{@email} as a collaborator. Make sure he create an account on MockupGo with this email address."
    end

    redirect_to edit_project_path(@project)
  end

  def destroy
  end
end
