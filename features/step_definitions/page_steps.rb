When /^he visits the project page$/ do
  visit project_path(@project)
end

When /^he creates a new Page$/ do
  fill_in "Name", :with => 'My Home Page'
  click_button 'Create page'
end

Then /^he should see the Page in the list$/ do
  page.should have_content 'My Home Page'
end

Given /^I have a project named "(.*?)"$/ do |project_name|
  @user.projects.create!(name: project_name)
end

Given /^I the project "(.*?)" has a page named "(.*?)"$/ do |project_name, page_name|
  @project = @user.projects.find_by_name(project_name)
  @project.pages.create!(name: page_name)
end

When /^I visit the page for project "(.*?)"$/ do |arg1|
  visit project_path(@project)
end

When /^I click on the link "(.*?)"$/ do |link_name|
  click_link link_name
end

Then /^I should see a page named "(.*?)"$/ do |page_title|
  page.should have_css('h1', :text => page_title)
end