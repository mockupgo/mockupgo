When /^he click on "(.*?)"$/ do |name|
  click_on name
end


Given /^(?:the user|he) visits his dashboard page$/ do
  visit dashboard_path
end


When /^the user create a new project$/ do
  # click_button 'New project'
  fill_in "Name",    :with => 'new project name'
  click_button 'Create Project'
end


Given /^he has already a project$/ do
  @project = @user.projects.create!(name: 'test project', owner: @user)
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
  @project.collaborators << @user
  @project.save
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

Given /^a user john@example\.com$/ do
  @john = User.create!(email: 'john@example.com',
                        password: '314159',
                        password_confirmation: '314159')
end

Given /^Matt has a project named "(.*?)"$/ do |project_name|
  @matt_project = @matt.projects.create!(name: project_name, owner: @matt)
end

Given /^Bob has a project named "(.*?)"$/ do |project_name|
  @bob_project = @bob.projects.create!(name: project_name, owner: @bob)
end

Then /^Bob should be redirected to the "(.*?)" project page$/ do |project_name|
  project = @bob.projects.find_by_name(project_name)
  page.current_path.should == project_path(project)
  page.status_code.should == 200
end

Given /^(?:I am|he is) not signed in$/ do
  # by default I am not signed in, but how can I make sure...
end


When /^I visit "Matt's cool project" project page$/ do
  visit project_path(@matt_project.id)
end


Given /^a signed in user Bob$/ do
  @bob = User.create(email: 'bob@example.com',
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

Then /^he should see "(.*?)"$/ do |content|
  page.should have_content(content)
end

Then /^he should see "(.*?)" in a table$/ do |content|
  within(:css, "table") do
    page.should have_content(content)
  end
end

Then /^he should see "(.*?)" in a table (\d+) time$/ do |content, time|
  within(:css, "table") do
    page.should have_selector("td:contains('" + content + "')", :count => time)
  end
end

Then /^he should not see "(.*?)" in a table$/ do |content|
  within(:css, "table") do
    page.should_not have_selector("td:contains('" + content + "')")
  end
end

Then /^he should see an error message$/ do
  page.should have_selector(".alert-error", :content => "You can't access this project.")
end


Then /^he should be redirected to the dashboard page$/ do
  page.current_path.should == dashboard_path
  page.status_code.should == 200
end


Then /^he should see "(.*?)" project page$/ do |project_name|
  project = Project.find_by_name(project_name)
  page.current_path.should == project_path(project)
  page.status_code.should == 200
end


When /^Matt submits valid signing information$/ do
  fill_in "Email",    :with => @matt.email
  fill_in "Password", :with => @matt.password
  click_button "Sign in"
end


When /^he fill "(.*?)" with "(.*?)"$/ do |field_name, value|
  fill_in field_name, :with => value
end

Given /^Matt is a collaborator for project "(.*?)"$/ do |project_name|
  project = Project.find_by_name(project_name)
  project.collaborators << @matt
  project.save
end

Given /^Bob is a collaborator for project "(.*?)"$/ do |project_name|
  project = Project.find_by_name(project_name)
  project.collaborators << @bob
  project.save
end

When /^he click on "(.*?)" for user "(.*?)" in the collaborators table$/ do |button_name, user_email|
  user = User.find_by_email(user_email)
  within(:css, "tr#user_#{user.id}") do
    click_on button_name
  end
end

When /^he should not see "(.*?)" in the collaborators table$/ do |content|
  within(:css, "table#collaborators-table") do
    page.should_not have_content(content)
  end
end

When /^I should not see a button "(.*?)" for user "(.*?)" in the collaborators table$/ do |button_name, user_email|
  user = User.find_by_email(user_email)
  within(:css, "table#collaborators-table tr#user_#{user.id}") do
    page.should_not have_css("a", text: button_name)
  end
end

Then /^he should see "(.*?)" for user "(.*?)" in the collaborators table$/ do |content, user_email|
  user = User.find_by_email(user_email)
  within(:css, "table#collaborators-table tr#user_#{user.id}") do
    page.should have_content(content)
  end
end


Given /^the project "(.*?)" has a mockup named "(.*?)"$/ do |project_name, mockup_name|
  steps %{
    And I visit the page for project "#{project_name}"
    When I choose the file "#{mockup_name}.jpg" to import
    And I click on "Import"
}

end

When /^Bob go on the preview page for "(.*?)" on project "(.*?)"$/ do |mockup_name, project_name|
  project = Project.find_by_name(project_name)
  mockup  = project.pages.find_by_name(mockup_name)
  version = mockup.latest_version

  visit preview_image_version_path(version)
end

Then /^he should be on the preview page for "(.*?)" on project "(.*?)"$/ do |mockup_name, project_name|
  project = Project.find_by_name(project_name)
  mockup  = project.pages.find_by_name(mockup_name)
  version = mockup.latest_version
  
  page.current_path.should == preview_image_version_path(version)
  page.status_code.should == 200
end

