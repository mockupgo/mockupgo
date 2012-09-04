Given /^a user visits the sign in page$/ do
  visit new_user_session_path
end

Given /^the user has an account$/ do
  @user = User.create(email: 'example@example.com',
                        password: '314159',
                        password_confirmation: '314159')
end

When /^(?:the user|he) submits valid signing information$/ do
  fill_in "Email",    :with => @user.email
  fill_in "Password", :with => @user.password
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
  page.current_path.should == new_user_session_path
  page.should have_selector('legend', text: 'Sign in')
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

Given /^a non signed in person$/ do
  # What should I do here ? 
end

When /^he visits the home page$/ do
  visit root_path
end

Then /^(?:I|he|the user) should be redirected to the sign in page$/ do
  page.current_path.should == new_user_session_path
  page.status_code.should == 200
end

Then /^(?:I|he|the user) should be redirected to his dashboard$/ do
  page.current_path.should == dashboard_path
  page.status_code.should == 200
end




