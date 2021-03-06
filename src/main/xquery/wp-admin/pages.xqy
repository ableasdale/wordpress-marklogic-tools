xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

view-tools:create-wp-admin-html-page("Pages", (),
    <div id="pages" class="row">
        <h5>TODO filter by all dates, bulk actions etc...</h5>
        <table class="table table-striped table-bordered">
            {view-tools:create-thead-element(("ID", "Title", "Status", "Author", "Comments", "Date"))}
            <tbody>
                {   (: TODO - can we further parameterise this? :)
                    for $x in ml-wp-data:get-pages()/*
                    order by number($x/wp:post_id) descending
                    return element tr {
                        element td {attribute class {"text-center"}, view-tools:create-badge-link(fn:concat("/wp-admin/editor.xqy?id=",fn:string($x/wp:post_id)), string($x/wp:post_id)) },
                        element td {view-tools:create-href-link( fn:concat("/wp-admin/editor.xqy?id=",fn:string($x/wp:post_id)), string($x/title)) },
                        element td {view-tools:build-document-state-dropdown(string($x/wp:status))},
                       (: TODO - get author first and suranme from dc:creator:::  element td {string($x/wp:author_first_name) || " " || string($x/wp:author_last_name)}, :)
                        element td {string($x/dc:creator)},
                        element td {attribute class {"text-center"}, view-tools:create-badge-link(fn:concat("/wp-admin/editor.xqy?id=", string(fn:count($x/wp:comment))), string(fn:count($x/wp:comment)))},
                        element td {attribute class {"date"}, xs:string($x/pubDate)}
                    }   
                }
            </tbody>                
        </table>
    </div>)