Given /^(?:the user|he) visits his dashboard page$/ do
  visit dashboard_path
end

When /^the user create a new project$/ do
  # click_button 'New project'
  fill_in "Name",    :with => 'new project name'
  click_button 'Create project'
end

Given /^he has already a project$/ do
  @user.projects.create!(name: 'test project')
end

Then /^(?:the user|he) should see his project listed$/ do
	@user.projects.each do |project|
	  	page.should have_content project.name
	end
end

Then /^he should see a new project on the page$/ do
  page.should have_selector('li', text: 'new project name')
end

Given /^the user as a project named "(.*?)"$/ do |project_name|
  @project = FactoryGirl.create(:project, user: @user, name: project_name)
end

When /^he click on the link "(.*?)"$/ do |link_name|
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

Given /^I am not signed in$/ do
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

When /^Bob visits his dashboard$/ do
  visit dashboard_path
end

Then /^he should not see "(.*?)"$/ do |content|
  page.should_not have_content(content)
end

When /^Bob visits "Matt's cool project" project page$/ do
  visit project_path(@matt_project.id)
end

Then /^he should see an error message$/ do
  page.should have_selector(".alert-error", :content => "You can't access this project.")
end



