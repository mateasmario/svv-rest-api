Feature: API testing of a Fake API
  Swagger URL: https://fakerestapi.azurewebsites.net/index.html

  Scenario: When user requests for an existing activity id, the activity should be returned
    Given An activity id
    When The user requests for an activity with a specific id
    Then The requested activity should be returned

  Scenario: The user successfully adds a new activity
    Given An id of an activity that does not exist
    When The user creates a new activity with that id
    Then The activity should be created successfully

  Scenario: The user can successfully delete an author
    Given An id of an author that exists
    When The user deletes the author with the specific id
    Then The author should be successfully deleted

  Scenario: The user is able to update an existing book
    Given An id of a book that exists
    When The user updates the book
    Then The book should be successfully updated
