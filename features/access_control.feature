Feature: Access control

	Scenario: a user can't see another user dashboard when signed in
		Given a signed in user
		When the user go to the dashboard of another user
		Then the user should see his own dashboard

	Scenario: a signed in person can't see a user dashboards
		Given a user that is not signed in
		When the user goes to a user dashboard
		Then the user should see the signin page