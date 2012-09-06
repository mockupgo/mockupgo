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
		And he clicks on the link "Delete project"
		# Then he should see an confirmation dialog
		# When he click ok on the confirmation dialog
		Then he should be redirected to the dashboard page
		And he should not see "My Cool Project"

	@wip
	Scenario: a user can't delete a project when he is not the project's owner

	Scenario: a non signed in user shouldn't access any user's project
		Given a user matt@example.com
		And Matt has a project named "Matt's cool project"
		And I am not signed in
		When I visit "Matt's cool project" project page
		Then I should be redirected to the sign in page

	Scenario: a signed in user shouldn't see another user's project on his dashbaord
		Given a user matt@example.com
		And Matt has a project named "Matt's cool project"
		And a signed in user Bob
		When Bob visits his dashboard
		Then he should not see "Matt's cool project"
	
	Scenario: another signed in user should not access any other user's project
		Given a user matt@example.com
		And Matt has a project named "Matt's cool project"
		And a signed in user Bob
		When Bob visits "Matt's cool project" project page
		Then he should be redirected to his dashboard
 		And he should see an error message