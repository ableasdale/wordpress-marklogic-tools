xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

view-tools:create-wp-admin-html-page("Pages", (),
    <div id="pages">
        <h3>TODO filter by all dates, bulk actions etc...</h3>
        <table class="table table-striped table-bordered">
            {view-tools:create-thead-element(("ID", "Title", "Status", "Author", "Comments", "Date"))}
            (: TODO - can we further parameterise this? :)
            <tbody>
                {
                    for $x in ml-wp-data:get-pages()/*
                    order by number($x/wp:post_id) ascending
                    return element tr {
                        element td {attribute class {"text-center"}, view-tools:create-badge-link(fn:concat("/editor.xqy?id=",fn:string($x/wp:post_id)), string($x/wp:post_id))},
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
    </div>)