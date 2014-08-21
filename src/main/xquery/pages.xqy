xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";

import module namespace wp-export-data = "http://www.xmlmachines.com/wp-export-data" at "/lib/wp-export-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

view-tools:create-html-page(
    <div id="content">
        <h2>Pages</h2>
        <h3>TODO filter by all dates, bulk actions etc...</h3>
        <div id="pages">
            <table>
                {view-tools:create-thead-element(("ID, "Title", "Status", "Author", "Comments", "Date"))}
                <!-- TODO - and parameterise this -->
                <tbody>
                    {
                        for $x in wp-export-data:get-pages()
                        return element tr {
                            element td {string($x/wp:post_id)}
                            element td {string($x/title)},
                            element td {string($x/wp:status)},                              
                           (: TODO - get author first and suranme from dc:creator:::  element td {string($x/wp:author_first_name) || " " || string($x/wp:author_last_name)}, :)
                            element td {string($x/dc:creator)},
                            (: TODO - can you put in multiple categories :)
                            element td {fn:count($x/wp:comment)},
                            element td {string($x/wp:post_date)}
                        }   
                    }
                </tbody>
                
            </table>
        </div>
    </div>)
