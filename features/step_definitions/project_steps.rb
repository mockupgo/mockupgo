Given /^the user visits his dashboard page$/ do
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

Then /^he should see his project listed$/ do
	@user.projects.each do |project|
	  	page.should have_content project.name
	end
end

Then /^he should see a new project on the page$/ do
  page.should have_selector('li', text: 'new project name')
end