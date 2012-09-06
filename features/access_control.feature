Feature: Access control

	Scenario: a user can't see his dashboard when not signed in
		When he visits his dashboard page
		Then he should be redirected to the sign in page