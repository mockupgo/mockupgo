Feature: a user can manage Page in a Project


    Scenario: I can visit the "page" page
        Given a signed in user
        And I have a project named "My website"
        And I the project "My website" has a page named "home page"

        When I visit the page for project "My website"
        And I click on the link "home page"

        Then I should see a page named "home page"


    Scenario: I can delete a "page"
        Given a signed in user
        And I have a project named "My website"
        And I the project "My website" has a page named "home page"
        And I visit the page for project "My website"
        And I click on the link "home page"

        When I click on "Delete"

        Then I should see a confirmation message "The page has been deleted"
        And I should be redirected to the "My website" project page
        And I should not see a link "home page"


    Scenario: I can create a new page by just uploading a new image mockup
        Given a signed in user
        And I have a project named "My website"

        And I visit the page for project "My website"

        When I choose the file "Hokusai.jpg" to import
        And I click on "Import"

        Then I should see a link "Hokusai"

