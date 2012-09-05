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