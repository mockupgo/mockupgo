class ProjectsUsersController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @email   = params[:email]

    @new_collaborator = User.find_by_email(@email)

    if @new_collaborator
      if @project.collaborators.exists?(@new_collaborator)
        flash[:error] = "#{@email} is aleady a collaborator for this project."
      else
        @project.collaborators << @new_collaborator
        flash[:notice] = "#{@email} was added to this project."
      end
    else
      flash[:error]  = "Could not add #{@email} as a collaborator. Make sure he create an account on MockupGo with this email address."
    end

    redirect_to edit_project_path(@project)
  end

  def destroy
  end
end
