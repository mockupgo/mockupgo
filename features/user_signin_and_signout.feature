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

		