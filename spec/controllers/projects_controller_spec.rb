require 'spec_helper'

describe ProjectsController do
  describe "POST create" do
    context "when signed in as a user" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user  
      end

      it "should save the project" do
        expect do
          post :create, :project => { "name" => "project name" }
        end.to change(Project, :count).by(1)
      end

      it "redirect to the dashboard" do
        post :create
        response.should redirect_to dashboard_path
      end
    end
  end
end
