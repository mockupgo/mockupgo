Feature: a user can manage Page in a Project

    Scenario: a user can create a new page in a project
        Given a signed in user
        And he has already a project
        When he visits the project page
        And he creates a new Page
        Then he should see the Page in the list

