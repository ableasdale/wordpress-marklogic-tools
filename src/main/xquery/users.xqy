xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";

import module namespace wp-export-data = "http://www.xmlmachines.com/wp-export-data" at "/lib/wp-export-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";



view-tools:create-wp-admin-html-page("Users", (),
    <div id="users">
        <table>
            {view-tools:create-thead-element(("Users", "Name", "Email", "Role", "Posts"))}
            <!-- TODO - and parameterise this -->
            <tbody>
                {
                    for $x in wp-export-data:get-authors()
                    return element tr {
                        element td {string($x/wp:author_login)},
                        element td {string($x/wp:author_first_name) || " " || string($x/wp:author_last_name)},
                        element td {string($x/wp:author_email)},
                        element td {"TODO"},
                        element td {"TODO"}
                    }   
                }
            </tbody>
            
        </table>
    </div>)