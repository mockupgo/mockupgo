Feature: a user can manage Page in a Project

    Scenario: I can create a new page in a project
        Given a signed in user
        And he has already a project
        When he visits the project page
        And he creates a new Page
        Then he should see the Page in the list


    Scenario: I can visit the "page" page
        Given a signed in user
        And I have a project named "My website"
        And I the project "My website" has a page named "home page"

        When I visit the page for project "My website"
        And I click on the link "home page"

        Then I should see a page named "home page"


    Scenario: I can visit delete a "page"
        Given a signed in user
        And I have a project named "My website"
        And I the project "My website" has a page named "home page"
        And I visit the page for project "My website"
        And I click on the link "home page"

        When I click on "Delete page"

        Then I should see a confirmation message "The page has been deleted"
        And I should be redirected to the "My website" project page
        And I should not see a link "home page"