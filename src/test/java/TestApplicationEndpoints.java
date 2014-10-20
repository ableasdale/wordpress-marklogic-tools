/**
 * Created with IntelliJ IDEA.
 * User: alexb
 * Date: 19/10/14
 * Time: 11:09
 * To change this template use File | Settings | File Templates.
 */


import org.junit.Test;

import static com.jayway.restassured.RestAssured.given;
import static org.hamcrest.Matchers.containsString;

public class TestApplicationEndpoints {

    @Test
    public void TestRootResource() {
        given().when().auth().basic("q", "q").
                get("http://localhost:8003").
                then().log().body().statusCode(200).
                body(containsString("rewriter.xqy"));
    }

    /**
     * Dashboard Endpoint Test
     */
    @Test
    public void TestDashboardResource() {
        given().when().auth().basic("q", "q").
                get("http://localhost:8003/wp-admin/dashboard.xqy").
                then().log().body().statusCode(200).body(containsString("<h2>Dashboard</h2>"));
    }

    /**
     * Posts Endpoint Test
     */
    @Test
    public void TestPostsResource() {
        given().when().auth().basic("q", "q").
                get("http://localhost:8003/wp-admin/posts.xqy").
                then().log().body().statusCode(200).body(containsString("<h2>Posts</h2>"));
    }

    /**
     * Pages Endpoint Test
     */
    @Test
    public void TestPagesResource() {
        given().when().auth().basic("q", "q").
                get("http://localhost:8003/wp-admin/pages.xqy").
                then().log().body().statusCode(200).body(containsString("<h2>Pages</h2>"));
    }

    /**
     * CommentsEndpoint Test
     */
    @Test
    public void TestCommentsResource() {
        given().when().auth().basic("q", "q").
                get("http://localhost:8003/wp-admin/comments.xqy").
                then().log().body().statusCode(200).body(containsString("<h2>Comments</h2>"));
    }
}
