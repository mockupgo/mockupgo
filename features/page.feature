Feature: a user can manage Page in a Project


    Scenario: I can create a new page by just uploading a new image mockup
        Given a signed in user
        And I have a project named "My website"
        And I visit the page for project "My website"
        When I choose the file "Hokusai.jpg" to import
        And I click on "Import"
        And I click on the link "Hokusai"
        Then I should see a page named "Hokusai"

