Feature: API testing of a Fake API
  Swagger URL: https://fakerestapi.azurewebsites.net/index.html

  Scenario: When user requests for an existing activity id, the activity should be returned
    Given A list of activities is available
    When The user requests for an activity with a specific id
    Then The requested activity should be returned

