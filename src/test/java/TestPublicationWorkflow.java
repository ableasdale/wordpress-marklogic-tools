import org.junit.Test;

import static com.jayway.restassured.RestAssured.given;
import static org.hamcrest.Matchers.containsString;

/**
 * Created with IntelliJ IDEA.
 * User: alexb
 * Date: 01/12/14
 * Time: 19:23
 * To change this template use File | Settings | File Templates.
 */
public class TestPublicationWorkflow {

    // Can I use RestAssured to Create a Quick Draft, submit it and then check to see whether it's been saved?


    @Test
    public void TestPostsResource() {
        given().when().auth().basic("q", "q").
                get("http://localhost:8003/wp-admin/posts.xqy").
                then().log().body().statusCode(200).body(containsString("<small>Posts</small>"));
    }
}
