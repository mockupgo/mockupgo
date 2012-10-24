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

	Scenario: display a project page
		Given a signed in user
		And the user has a project named "My Cool Project"
		When the user visits his dashboard page
		And he clicks on the link "My Cool Project"
		Then he should see a project page named "My Cool Project"

	Scenario: a user can delete a project
		Given a signed in user
		And the user has a project named "My Cool Project"
		When he visits "My Cool Project" project page

		And he clicks on the link "Edit"

		And he clicks on the link "Delete"
		# Then he should see an confirmation dialog
		# When he click ok on the confirmation dialog
		Then he should be redirected to the dashboard page
		And he should not see "My Cool Project"

	@wip
	Scenario: a user can't delete a project when he is not the project's owner

