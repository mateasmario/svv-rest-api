package ro.upt.test;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.junit.jupiter.api.Assertions;

public class StepDefinitions {
    private static final String BASE_URL = "https://fakerestapi.azurewebsites.net";
    private static final RequestSpecification requestSpecification;
    private static Response response;

    static {
        RestAssured.baseURI = BASE_URL;
        requestSpecification = RestAssured.given();
    }

    @Given("A list of activities is available")
    public void aListOfActivitiesIsAvailabie() {
        response = requestSpecification.get("/api/v1/Activities");
        Assertions.assertEquals(200, response.getStatusCode());
    }

    @When("The user requests for an activity with a specific id")
    public void theUserRequestsForAnActivityWithASpecificId() {
        response = requestSpecification
                .get("/api/v1/Activities/1");
    }

    @Then("The requested activity should be returned")
    public void theRequestedActivityShouldBeReturned() {
        Assertions.assertEquals(200, response.getStatusCode());
        Assertions.assertEquals(1, response.jsonPath().getInt("id"));
        Assertions.assertEquals("Activity 1", response.jsonPath().getString("title"));
        Assertions.assertEquals(false, response.jsonPath().getBoolean("completed"));
    }

}
