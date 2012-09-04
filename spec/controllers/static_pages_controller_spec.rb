require "spec_helper"

describe StaticPagesController do
  describe "GET dashboard" do
     
    context "when signed in" do
      it "should show only the signed in user's projects"
    end

    context "when not signed in" do
      it "should redirect to the sign in page"
    end
  end
end