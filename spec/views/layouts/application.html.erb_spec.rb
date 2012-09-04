require "spec_helper"

describe "layouts/application.html.erb" do

  context "signed in user" do

    before { @view.should_receive(:user_signed_in?).and_return(true) }

    it "should contain a link to the dashboard" do
      render
      rendered.should have_link("Dashboard", href: dashboard_path)
    end

    it "should contain a sign out link" do
      render
      rendered.should have_link("Sign out", href: destroy_user_session_path)
    end

    context "there is an flash[:notice]" do
      let(:flash_msg) { "This is a flash notice" }
      before do
        flash[:notice] = flash_msg
        render
      end

      it "display the flash messages" do
        rendered.should have_content(flash_msg)
      end
    end

    context "there is an flash[:alert]" do
      let(:flash_msg) { "This is a flash notice" }
      before do
        flash[:alert] = flash_msg
        render
      end

      it "display the flash messages" do
        rendered.should have_content(flash_msg)
      end
    end

  end
end