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


      before do
        @image_filename = "Hokusai.jpg"
        @image_file_src = Rails.root. + "features/fixtures/" + @image_filename
        @request.env['CONTENT_TYPE'] = 'multipart/form-data'
        @image_file = Rack::Test::UploadedFile.new(@image_file_src)
      end

      it "should create a new page" do
        expect do
          post :create, :project_id => project.id, :image_version => {image: @image_file}
        end.to change(Page, :count).by(1)
      end
    end
  end
end
