# API Testing with RestAssured and Cucumber

### Installing required dependencies

We will first need to add the required dependencies for the [RestAssured](https://rest-assured.io/) library, including [jackson-databind](https://github.com/FasterXML/jackson-databind) for proper JSON object mapping.

````xml
<dependency>
    <groupId>io.rest-assured</groupId>
    <artifactId>rest-assured</artifactId>
    <version>5.5.0</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.18.1</version>
</dependency>
````

[Cucumber](https://cucumber.io/docs/cucumber/) requires the following dependencies:

````xml
<dependency>
    <groupId>io.cucumber</groupId>
    <artifactId>cucumber-java</artifactId>
    <version>7.20.1</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>io.cucumber</groupId>
    <artifactId>cucumber-junit</artifactId>
    <version>7.20.1</version>
</dependency>
````
We also need to add a dependency for the JUnit API, which provides the `Assertions` class:
````xml
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter-api</artifactId>
    <version>5.11.3</version>
    <scope>test</scope>
</dependency>
````

### Sending requests with RestAssured (quick start)

For the below example, we will use the UI available at https://fakerestapi.azurewebsites.net/index.html.

#### 1. Sending simple GET requests for one item

![image](https://github.com/user-attachments/assets/55c366f2-b5fd-4618-a4de-d6edad8647c0)

````java
String BASE_URL = "https://fakerestapi.azurewebsites.net";

RestAssured.baseURI = BASE_URL;
RequestSpecification requestSpecification = RestAssured.given();
Response response = requestSpecification.get("/api/v1/Activities/1");

Assertions.assertEquals(200, response.getStatusCode());
Assertions.assertEquals(1, response.jsonPath().getInt("id"));
Assertions.assertEquals("Activity 1", response.jsonPath().getString("title"));
Assertions.assertEquals(false, response.jsonPath().getBoolean("completed"));
````

#### 2. Sending GET requests for multiple items (checking the size of the list)

![image](https://github.com/user-attachments/assets/55d18db9-3b3c-4705-b1f0-0a638ba3c7d1)

````java
String BASE_URL = "https://fakerestapi.azurewebsites.net";

RestAssured.baseURI = BASE_URL;
RequestSpecification requestSpecification = RestAssured.given();
Response response = requestSpecification.get("/api/v1/Activities");

Assertions.assertEquals(200, response.getStatusCode());
// Take the list returned by the GET request, and check its size (in our case, the API returns a list with 200 elements)
Assertions.assertEquals(200, response.jsonPath().getList("").size());
````


#### 3. Sending POST requests (with body)

![image](https://github.com/user-attachments/assets/0979f177-dcd4-43e4-b0e3-9c580318efd5)

````java
String BASE_URL = "https://fakerestapi.azurewebsites.net";

RestAssured.baseURI = BASE_URL;
RequestSpecification requestSpecification = RestAssured.given();

JsonObject requestParams = new JsonObject();
requestParams.add("id", "16");
requestParams.add("idBook", "32");
requestParams.add("firstName", "John");
requestParams.add("lastName", "Doe");

Response response = requestSpecification
        .contentType("application/json")
        .body(requestParams.toString())
        .post("/api/v1/Authors");

Assertions.assertEquals(200, response.getStatusCode());
````

#### 4. Sending POST requests (with Authorization header and JWT token)

````java
String BASE_URL = "BASE URL GOES HERE";

RestAssured.baseURI = BASE_URL;
RequestSpecification requestSpecification = RestAssured.given();

Response response = requestSpecification
        .contentType("application/json")
        .header(new Header("Authorization", "Bearer TOKEN")) // requires a JWT token
        .body("BODY GOES HERE")
        .post("URL GOES HERE");

Assertions.assertEquals(200, response.getStatusCode());
````

### Behavior-driven development with Cucumber

#### The feature file

A `*.feature` file needs to be created in the `src/test/resources` directory. The file will contain customer requirements in the english language.

````gherkin
Feature: API testing of a Fake API
  Swagger URL: https://fakerestapi.azurewebsites.net/index.html

  Scenario: When user requests for an existing activity id, the activity should be returned
    Given A list of activities is available
    When The user requests for an activity with a specific id
    Then The requested activity should be returned
````

The `Given`, `When` and `Then` steps will be implemented in the step definition class.

#### The step definition class

The scenarios defined in the previous file need to be specified in the corresponding annotations, inside the step definition class. This class will also contain the test logic:

````java
public class StepDefinitions {
    @Given("A list of activities is available")
    public void aListOfActivitiesIsAvailabie() {
      // ToDo: Implement logic
    }

    @When("The user requests for an activity with a specific id")
    public void theUserRequestsForAnActivityWithASpecificId() {
      // ToDo: Implement logic
    }

    @Then("The requested activity should be returned")
    public void theRequestedActivityShouldBeReturned() {
      // ToDo: Implement logic
    }
}
````

The step definiton will contain all of the API requests, together with required assertions.

#### The runner class

The step definition class is not runnable. Cucumber requires a special annotated class to run the step definitions.

````java
import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = "src/test/resources/features",
        glue="ro.upt.test"
)
public class TestRunner {
}
````
`features` specifies the directory where the feature files reside, while `glue` specifies the package of the step definition file.
