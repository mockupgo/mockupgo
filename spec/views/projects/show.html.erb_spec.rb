require "spec_helper"

describe "projects/show.html.erb" do
  it "display the name of the project for title" do
  	assign(:project, stub("Project", name: "My cool project"))
  	render
  	rendered.should have_selector('h1', content: 'My cool project')
  end

  it "display flash messages"
  
end