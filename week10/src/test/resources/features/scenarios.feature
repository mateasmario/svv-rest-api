Feature: API testing of a Fake API
  Documentation URL: https://reqres.in/

  Scenario: A paginated list of users is retrieved
    Given A page number is chosen
    When Getting the users on that page
    Then The list of users should be returned

  Scenario: A user with a certain id is retrieved
    Given Some users (regardless of id) exist in the database and an id is chosen
    When The details of the user with that id are asked for
    Then Details should be returned

  Scenario: A new user is created
    Given Information about a new user is initialized
    When The creation request is made
    Then The user should be successfully created

  Scenario: A user can be deleted
    Given An id is chosen and the user with that id exists in the database
    When The user is deleted
    Then The deletion process is completed successfully
