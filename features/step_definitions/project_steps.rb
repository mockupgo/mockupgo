Given /^(?:the user|he) visits his dashboard page$/ do
  visit dashboard_path
end


When /^the user create a new project$/ do
  # click_button 'New project'
  fill_in "Name",    :with => 'new project name'
  click_button 'Create Project'
end


Given /^he has already a project$/ do
  @project = @user.projects.create!(name: 'test project')
end


Then /^(?:the user|he) should see his project listed$/ do
	@user.projects.each do |project|
	  	page.should have_content project.name
	end
end


Then /^he should see a new project on the page$/ do
  page.should have_selector('li', text: 'new project name')
end


Given /^the user has a project named "(.*?)"$/ do |project_name|
  @project = FactoryGirl.create(:project, owner: @user, name: project_name)
end


When /^(?:Bob|he) visits "(.*?)" project page$/ do |name|
  project = Project.find_by_name!(name)
  visit project_path(project)
end


When /^he clicks on the link "(.*?)"$/ do |link_name|
  click_link link_name
end


Then /^he should see a project page named "(.*?)"$/ do |project_name|
    page.should have_selector('h1', text: project_name)
end


Given /^a user matt@example\.com$/ do
  @matt = User.create!(email: 'matt@example.com',
                        password: '314159',
                        password_confirmation: '314159')
end


Given /^Matt has a project named "(.*?)"$/ do |project_name|
  @matt_project = @matt.projects.create!(name: project_name)
end


Given /^(?:I am|he is) not signed in$/ do
  # by default I am not signed in, but how can I make sure...
end


When /^I visit "Matt's cool project" project page$/ do
  visit project_path(@matt_project.id)
end


Given /^a signed in user Bob$/ do
  @bob = User.create(email: 'example@example.com',
                        password: '314159',
                        password_confirmation: '314159')
  visit new_user_session_path
  fill_in "Email",    :with => @bob.email
  fill_in "Password", :with => @bob.password
  click_button "Sign in"
end


When /^(?:Bob|he) visits his dashboard$/ do
  visit dashboard_path
end


Then /^he should not see "(.*?)"$/ do |content|
  page.should_not have_content(content)
end


Then /^he should see an error message$/ do
  page.should have_selector(".alert-error", :content => "You can't access this project.")
end


Then /^he should be redirected to the dashboard page$/ do
  page.current_path.should == dashboard_path
  page.status_code.should == 200
end


Then /^he should see "Matt's cool project" project page$/ do
  page.current_path.should == project_path(@matt_project.id)
  page.status_code.should == 200
end


When /^Matt submits valid signing information$/ do
  fill_in "Email",    :with => @matt.email
  fill_in "Password", :with => @matt.password
  click_button "Sign in"
end
