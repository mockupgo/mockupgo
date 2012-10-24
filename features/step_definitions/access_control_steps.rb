Given /^Matt has uploaded a page "(.*?)"$/ do |page_name|
  @matt_page = @matt_project.pages.create!(name: page_name)
  @matt_page.image_versions.create!()
end

When /^I try to access the preview page for "(.*?)"$/ do |page_name|
  page = Page.find_by_name(page_name)
  visit preview_image_version_path(page.latest_version)
end