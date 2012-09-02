Feature: account sign up
	
	Scenario: a user can't sign up for a new account
		Given a new user
		When he go to the sign up page
		Then he should see a message asking to contact the site's owner