Feature: A project can have multiple collaborators
    Collaborators see the project they have been granted access in their dashboard

    Collaborators can do everything that the Owner can do except deleting the project and inviting other collaborators

    @wip
    Scenario: As a project owner, I can invite another MockupGo user to collaborate on my project
        Given a user matt@example.com
        And Matt has a project named "Matt's cool project"
        And a signed in user Bob
        And Bob has a project named "Bob's collaboration project"

        When he visits "Bob's collaboration project" project page
        And he clicks on the link "Manage project"
        And he fill "email" with "matt@example.com"
        And he click on "Add collaborator"

        Then he should see "matt@example.com" in the table
        # test more ?