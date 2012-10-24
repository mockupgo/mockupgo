Feature: Access control

	Scenario: a user can't see his dashboard when not signed in
		When he visits his dashboard page
		Then he should be redirected to the sign in page

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

    Scenario: a non signed is redirected to the sign in page when he tries to access an image_version preview
        Given a user matt@example.com
        And Matt has a project named "Matt's cool project"
        And Matt has uploaded a page "Hokusai"

        When I am not signed in
        And I try to access the preview page for "Hokusai"
        Then I should be redirected to the sign in page

    @wip
    Scenario: I can be automatically signed in and access preview page with a special link
        Given a user matt@example.com
        And Matt has a project named "Matt's cool project"
        And Matt has uploaded a page "Hokusai"

        Given a user bob@example.com
        And Bob has been granted access to "Matt's cool project"
        And Bob has received a link to access the preview page for "Hokusai"

        Given Bob is not signed in
        When Bob visit the direct access link he has received
        Then he should see the preview page for "Hokusai"


