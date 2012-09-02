require 'spec_helper'

describe ProjectsController do

  describe "POST create" do
  
    context "when signed in as a user" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user  
      end

      context "when the project saves successfully" do
        it "should save the project" do
          expect do
            post :create, :project => { "name" => "project name" }
          end.to change(Project, :count).by(1)
        end

        it "sets a flash[:notice] message" do
          post :create, :project => { "name" => "project name" }
          flash[:notice].should eq('Project created successfully.')
        end

        it "redirect to the dashboard" do
          post :create, :project => { "name" => "project name" }
          response.should redirect_to dashboard_path
        end
      end

      context "when the project fails to save" do
        before(:each) do
          controller.stub(:current_user => @user)

          # new_project = double('new project')
          new_project = Project.new(name: "test project")
          new_project.stub(:save => false)

          project_rel = double('projects list')
          project_rel.stub(:build => new_project)

          @user.stub(:projects => project_rel)
        end

        it "sets a flash[:notice] message" do
          post :create, :project => { "name" => "project name" }
          flash[:notice].should eq('Project failed to save.')
        end

      end
    end

    context "when no signed in" do
      it "should not save the project" do
        expect do
          post :create, :project => { "name" => "project name" }
        end.to change(Project, :count).by(0)
      end

      it "should redirect to the sign in page" do
        post :create
        response.should redirect_to new_user_session_path
      end
      
    end
  end
end
