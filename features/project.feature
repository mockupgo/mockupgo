Feature: User can manage there projects
	In order to organize his work
	As a user
	Should be able to manage its own project

	Scenario: user's projects are displayed on the dashboard page
		Given a signed in user
		And he has already a project
		And the user visits his dashboard page
		Then he should see his project listed

	Scenario: create a project
		Given a signed in user
		And the user visits his dashboard page
		When the user create a new project
		Then he should see a new project on the page