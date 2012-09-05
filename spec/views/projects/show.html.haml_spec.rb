require "spec_helper"

describe "projects/show.html.haml" do
  before do
    # assign(:project, mock_model("Project", name: "My cool project", id: 1).as_null_object)
    assign(:project, FactoryGirl.create(:project))
  end

  it "display the name of the project for title" do
  	render
  	rendered.should have_selector('h1', content: 'My cool project')
  end
  
end