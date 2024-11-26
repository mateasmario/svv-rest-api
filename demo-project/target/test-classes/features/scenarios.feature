Feature: API testing of a Fake API
  Swagger URL: https://fakerestapi.azurewebsites.net/index.html

  Scenario: When user requests for an existing activity id, the activity should be returned
    Given A list of activities is available
    When The user requests for an activity with a specific id
    Then The requested activity should be returned

  Scenario: The user successfully adds a new activity
    Given An activity id that does not exist
    When The user creates a new activity with that id
    Then The activity should be created successfully

  Scenario: The user can successfully delete an author
    Given An author id that already exists
    When The user deletes the author with the specific id
    Then The author should be successfully deleted

  Scenario: The user is able to get the entire list of books
    Given A list of books is available
    When The user requests for all books
    Then All books should be returned