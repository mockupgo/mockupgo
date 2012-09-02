Feature: Access control

	Scenario: a user can't see his dashboard when not signed in
		When the user go to the dashboard page
		Then he should see the login page