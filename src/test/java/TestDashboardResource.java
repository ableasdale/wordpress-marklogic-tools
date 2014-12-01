/**
 * Created with IntelliJ IDEA.
 * User: alexb
 * Date: 01/12/14
 * Time: 17:14
 * To change this template use File | Settings | File Templates.
 */

import org.junit.Test;

import static com.jayway.restassured.RestAssured.DEFAULT_BODY_ROOT_PATH;
import static com.jayway.restassured.RestAssured.given;
import static org.hamcrest.Matchers.*;

public class TestDashboardResource {

    @Test
    public void TestDashboardResourceAvailability() {
        given().when().auth().basic("q", "q").
                get("http://localhost:8003/wp-admin/dashboard.xqy").
                then().log().body().statusCode(200).
                body(containsString("<h2>Dashboard</h2>"));
    }

    @Test
    public void TestAtAGlanceWidget() {
        given().when().auth().basic("q", "q").
                get("http://localhost:8003/wp-admin/dashboard.xqy").
                then().log().body().statusCode(200).
                body(containsString("At a Glance"));
                //body(contains())
    }

    @Test
    public void TestActivityWidget(){
        given().when().auth().basic("q", "q").
                get("http://localhost:8003/wp-admin/dashboard.xqy").
                then().log().body().statusCode(200).

                body(containsString("Recently published"));

    }

    @Test
    public void TestQuickDraftWidget(){
        given().when().auth().basic("q", "q").
                get("http://localhost:8003/wp-admin/dashboard.xqy").
                then().log().body().statusCode(200).
                body(hasXPath("/html/body/div"));   //[@class eq 'container']"));
                // TODO - when i have access to the web - figure out how to test attribs...
                // [@class = 'container'])); // [@id = container]"));
                //body(containsString("Quick Draft"));


    }




}
