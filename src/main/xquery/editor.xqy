xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 

import module namespace wp-export-data = "http://www.xmlmachines.com/wp-export-data" at "/lib/wp-export-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

declare variable $id as xs:integer := xdmp:get-request-field("id") cast as xs:integer;
declare variable $item as element(item) := wp-export-data:get-wp-post-by-id($id);

view-tools:create-wp-admin-html-page("Editor", view-tools:get-tiny-mce-js(),

    (   <div id="editor">
            <form>
            {element input {
                    attribute name {"title"},
                    attribute value {$item/title/string()}
                }             
            }
            <p>TODO: No permalink impl</p>
            <textarea>{$item/content:encoded}</textarea>
            <button>Save Changes</button>
            </form>
        </div>
    )
)
