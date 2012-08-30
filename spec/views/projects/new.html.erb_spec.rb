require 'spec_helper'

describe "projects/new.html.erb" do

  it "render a form to create a project" do
    assign(:project, mock_model("Project").as_new_record.as_null_object)
    render
    rendered.should have_selector("form[method=post][action='#{projects_path}']")
    Capybara.string(rendered).find('form').should have_selector("input[type=submit]")

  end

  it "render a text field for the project name" do
    assign(:project, mock_model("Project").as_new_record.as_null_object)
    render
    Capybara.string(rendered).find('form').should have_selector("input[type=text][name='project[name]']")
  end
end