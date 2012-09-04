require "spec_helper"

describe StaticPagesController do
  describe "GET dashboard" do
     
    context "when signed in" do
      let(:user)         { FactoryGirl.create(:user, email: "first@example.com") }
      let(:another_user) { FactoryGirl.create(:user, email: "second@example.com") }

      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user  
      end

      let!(:p1) { FactoryGirl.create(:project, user: user, name: "project foo") }
      let!(:p2) { FactoryGirl.create(:project, user: user, name: "project bar") }

      let!(:q1) { FactoryGirl.create(:project, user: another_user, name: "other user project foo") }
      let!(:q2) { FactoryGirl.create(:project, user: another_user, name: "other user project bar") }

      it "should show the signed in user's projects" do
        get :dashboard
        assigns(:projects).should include(p1)
        assigns(:projects).should include(p2)
      end

      it "should not show other user's projects" do
        get :dashboard
        assigns(:projects).should_not include(q1)
        assigns(:projects).should_not include(q2)
      end
    end

    context "when not signed in" do
      it "should redirect to the sign in page" do
        get :dashboard
        response.should redirect_to new_user_session_path
      end
    end
  end
end