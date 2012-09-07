require 'spec_helper'

describe ProjectsController do

  describe "POST show" do

    context "when not signed in" do
      it "should redirect to the sign in page when when accessing a project page" do
        @project = FactoryGirl.create(:project)
        post :show, id: @project.id
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "POST create" do
  
    context "when signed in as a user" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user
        controller.stub(:current_user => @user)
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
          new_project = Project.new(name: "test project")
          new_project.stub(:save => false)
          @user.stub_chain(:projects, :build).and_return(new_project)
        end

        it "sets a flash[:notice] message" do
          post :create, :project => { "name" => "project name" }
          flash[:notice].should eq('Project failed to save.')
        end

      end

      describe "when trying to access another user's project" do
        let(:another_user) { FactoryGirl.create(:user, email: "another_user@example.com") }
        let(:another_user_project) { FactoryGirl.create(:project, user: another_user) }
        
        before { post :show, id: another_user_project.id }

        it "should redirect to the dashboard" do
          response.should redirect_to dashboard_path
        end

        it "should display an error flash message" do
          flash[:alert].should eq("You can't access this project.")
        end
      end
    end

    context "when not signed in" do
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

  describe "DESTROY" do
    context "when signed in as a user" do

      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user
        @project = FactoryGirl.create(:project, user: @user)
      end

      it "call #destroy on the model" do
        @user.stub_chain(:projects, :find_by_id).and_return(@project)
        controller.stub(:current_user => @user)

        @project.should_receive(:destroy)

        post :destroy, id: @project.id
      end

      it "should redirect to the dashboard" do
        post :destroy, id: @project.id
        response.should redirect_to dashboard_path
      end

    end
  end
end
