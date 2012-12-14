Feature: A project can have multiple collaborators
    Collaborators see the project they have been granted access in their dashboard

    Collaborators can do everything that the Owner can do except deleting the project and inviting other collaborators


    Scenario: As a project owner, I can invite another MockupGo user to collaborate on my project
        Given a user matt@example.com
        And Matt has a project named "Matt's cool project"
        And a signed in user Bob
        And Bob has a project named "Bob's collaboration project"

        When he visits "Bob's collaboration project" project page
        And he clicks on the link "Manage project"
        And he fill "email" with "matt@example.com"
        And he click on "Add collaborator"

        Then he should see "matt@example.com" in a table


    Scenario: if I add collaborator that is already in the collaborator list, I have an error message and the collaborator is not added again
        Given a user matt@example.com
        And Matt has a project named "Matt's cool project"
        And a signed in user Bob
        And Bob has a project named "Bob's collaboration project"
        And Matt is a collaborator for project "Bob's collaboration project"

        When he visits "Bob's collaboration project" project page
        Then he should see "matt@example.com" in a table 1 time

        When he clicks on the link "Manage project"
        And he fill "email" with "matt@example.com"
        And he click on "Add collaborator"

        Then he should see "matt@example.com" in a table 1 time
        And he should see "matt@example.com is aleady a collaborator for this project"


    Scenario: As the project's owner, I can remove a collaborator from the project
        Given a user matt@example.com
        And Matt has a project named "Matt's cool project"
        And a signed in user Bob
        And Bob has a project named "Bob's collaboration project"
        And Matt is a collaborator for project "Bob's collaboration project"

        When he visits "Bob's collaboration project" project page
        Then he should see "matt@example.com" in a table 1 time

        When he click on "remove access" for user "matt@example.com" in the collaborators table
        # And he should see "matt@example.com access has been removed from this project"
        And he should not see "matt@example.com" in the collaborators table


    Scenario: As a project owner, I can't delete myself as a collaborator
        Given a user matt@example.com
        And Matt has a project named "Matt's cool project"
        And a signed in user Bob
        And Bob has a project named "Bob's collaboration project"
        And Matt is a collaborator for project "Bob's collaboration project"

        When he visits "Bob's collaboration project" project page
        Then he should see "matt@example.com" in a table 1 time

        When I should not see a button "remove access" for user "bob@example.com" in the collaborators table


    Scenario: I can see who is the project's owner
        Given a user matt@example.com
        And Matt has a project named "Matt's cool project"
        And a signed in user Bob
        And Bob has a project named "Bob's collaboration project"
        And Matt is a collaborator for project "Bob's collaboration project"

        When he visits "Bob's collaboration project" project page
        Then he should see "owner" for user "bob@example.com" in the collaborators table


    Scenario: As a collaborator on a project, I can access the project's page
        Given a user matt@example.com
        And Matt has a project named "Matt's cool project"
        And a signed in user Bob
        And Bob is a collaborator for project "Matt's cool project"

        When the user visits his dashboard page
        When he click on "Matt's cool project"
        Then he should see a project page named "Matt's cool project"


    @wip
    Scenario: As a collaborator on a project, I can access a project's page mockup
        Given a user matt@example.com
        And Matt has a project named "Matt's cool project"
        And a signed in user Bob
        And Bob is a collaborator for project "Matt's cool project"
        And the project "Matt's cool project" has a mockup named "Hokusai"

        When Bob go on the preview page for "Hokusai" on project "Matt's cool project"
        Then he should be on the preview page for "Hokusai" on project "Matt's cool project"



    # Scenario: As a collaborator on a project, I can upload a new page mockup


    # Scenario: I can't access a project when I an not a collaborator (anymore)



    
    # Scenario: When I am not a collaborator on a project, I can not access a project's page mockup



    # Scenario: add a collaborator that is not with MockupGo propose to send an invite

    # Scenario: when you try to add yourself as a collaborator, you are not added to the list and an error message appear

    # Scenario: check that it is a valid email address (client side?)

    # Scenario: when you are project owner, you can't delete yourself as a collaborator

    # Scenario: when I try to add a collaborator to a project I am not the owner, I have an error message and the collaborator is not added