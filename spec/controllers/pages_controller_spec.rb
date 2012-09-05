require 'spec_helper'

describe PagesController do

  describe "POST create" do
    
    context "when signed in as a user" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user  
      end

      let!(:project) {  FactoryGirl.create(:project, user: @user) }

      it "should create a new page" do
        expect do
          post :create, project_id: project.id, name: 'My Home Page'
        end.to change(Page, :count).by(1)
      end



    end
  end

end
