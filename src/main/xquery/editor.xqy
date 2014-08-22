xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 

import module namespace wp-export-data = "http://www.xmlmachines.com/wp-export-data" at "/lib/wp-export-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

declare variable $id as xs:integer := xdmp:get-request-field("id") cast as xs:integer;


view-tools:create-wp-admin-html-page("Editor", view-tools:get-tiny-mce-js(),

    (
        <textarea>{wp-export-data:get-wp-post-by-id($id)/content:encoded}</textarea>,
        <button>Save Changes</button>
    )
)
