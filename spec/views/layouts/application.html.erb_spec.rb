require "spec_helper"

describe "layouts/application.html.erb" do

  context "there is an flash[:notice]" do
    let(:flash_msg) { "This is a flash notice" }
    before do
      @view.should_receive(:user_signed_in?).and_return(true)
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
      @view.should_receive(:user_signed_in?).and_return(true)
      flash[:alert] = flash_msg
      render
    end

    it "display the flash messages" do
      rendered.should have_content(flash_msg)
    end
  end


end