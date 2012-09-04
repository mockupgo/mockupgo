require "spec_helper"

describe "projects/show.html.erb" do
  before { assign(:project, stub("Project", name: "My cool project")) }

  it "display the name of the project for title" do
  	render
  	rendered.should have_selector('h1', content: 'My cool project')
  end
  
end