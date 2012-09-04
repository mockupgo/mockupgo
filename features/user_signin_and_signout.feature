Feature: User sign in and sign out
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

	Scenario: succesful sign in
		Given a user visits the sign in page
		And the user has an account
		When the user submits valid signing information
		Then the user should see his dashboard page
		And the user should see a sign out link

	Scenario: unsuccesful sign in
		Given a user visits the sign in page
		When the user submits invalid sign in information
		Then the user should see the sign in page
		And the user should not be signed in
		And there is an error message

	Scenario: sign out
		Given a signed in user
		When the user sign out
		Then the user should see the sign in page
		And the user should not be signed in

	Scenario: visiting the home page when not signed in redirects to signin page
		Given a non signed in person
		When he visits the home page
		Then he should be redirected to the sign in page

	Scenario: visiting the home page when signed in redirects to dashboard
		Given a signed in user
		When he visits the home page
		Then he should be redirected to his dashboard

	Scenario: a non signed in user is redirected to the page he wanted to visit after signing in
		Given a user matt@example.com
		And Matt has a project named "Matt's cool project"
		And he is not signed in
		When he visits "Matt's cool project" project page
		Then he should be redirected to the sign in page
		When Matt submits valid signing information
		Then he should see "Matt's cool project" project page