xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

view-tools:create-wp-admin-html-page("Users", (),
    <div id="users">
        <table class="table table-striped table-bordered">
            {view-tools:create-thead-element(("Users", "Name", "Email", "Role", "Posts"))}
            <tbody>
                {
                    for $x in ml-wp-data:get-authors()
                    return element tr {
                        element td {string($x//wp:author_login)},
                        element td {string($x//wp:author_first_name) || " " || string($x/wp:author_last_name)},
                        element td {string($x//wp:author_email)},
                        element td {"TODO"},
                        element td {attribute class {"text-center"}, view-tools:create-badge-link(fn:concat("#?id=","TODO-FIXME"), string(fn:count(ml-wp-data:get-posts-by-authorname(string($x//wp:author_login)))))}  
                    }   
                }
            </tbody>            
        </table>
    </div>
)