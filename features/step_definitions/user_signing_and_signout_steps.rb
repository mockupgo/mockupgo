Given /^a user visits the sign in page$/ do
  visit new_user_session_path
end

Given /^the user has an account$/ do
  @user = FactoryGirl.create(:user)
end

When /^the user submits valid signing information$/ do
  fill_in "Email",    :with => @user[:email]
  fill_in "Password", :with => '314159'
  click_button "Sign in"
end

Then /^the user should see his dashboard page$/ do
  page.should have_selector('h1', text: 'Dashboard')
end

Then /^the user should see a sign out link$/ do
  should have_link('Sign out', href: destroy_user_session_path)
end

When /^the user submits invalid sign in information$/ do
  fill_in "Email",    :with => 'example@example.com'
  fill_in "Password", :with => 'WRONG PASSWORD'
  click_button "Sign in"
end

Then /^the user should see the sign in page$/ do
  page.should have_selector('h2', text: 'Sign in')
end

Then /^the user should not be signed in$/ do
  should_not have_link('Sign out', href: destroy_user_session_path)
end

Given /^a signed in user$/ do
  visit new_user_session_path
  @user = FactoryGirl.create(:user)
  fill_in "Email",    :with => @user[:email]
  fill_in "Password", :with => '314159'
  click_button "Sign in"
end

When /^the user sign out$/ do
  click_link 'Sign out'
end

Then /^there is an error message$/ do
  page.should have_selector('.alert')
end