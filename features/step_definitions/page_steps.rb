Given /^I have a project named "(.*?)"$/ do |project_name|
  @user.projects.create!(name: project_name, owner: @user)
end

Given /^I the project "(.*?)" has a page named "(.*?)"$/ do |project_name, page_name|
  @project = Project.find_by_name(project_name)
  @project.pages.create!(name: page_name)
end

When /^I visit the page for project "(.*?)"$/ do |project_name|
  @project = Project.find_by_name(project_name) 
  visit project_path(@project)
end

When /^I click on the link "(.*?)"$/ do |link_name|
  click_link link_name
end

Then /^I should see a page named "(.*?)"$/ do |page_title|
  page.should have_css('h1', :text => page_title)
end

When /^I click on "(.*?)"$/ do |name|
  click_on name
end

Then /^I should see a confirmation message "(.*?)"$/ do |msg|
  page.should have_css('.alert-success', :text => msg)
end

Then /^I should be redirected to the "(.*?)" project page$/ do |project_name|
  project = @user.projects.find_by_name(project_name)
  page.current_path.should == project_path(project)
  page.status_code.should == 200
end

Then /^I should not see a link "(.*?)"$/ do |anchor_text|
  page.should_not have_selector('a', text: anchor_text)
end

Then /^I should see a link "(.*?)"$/ do |anchor_text|
  page.should have_selector('a', text: anchor_text)
end

When /^I choose the file "(.*?)" to import$/ do |filename|
  path = File.join(::Rails.root, "features/fixtures/", filename) 
  attach_file("image_version[image]", path)
end






