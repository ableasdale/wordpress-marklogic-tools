xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

view-tools:create-wp-admin-html-page("Posts", (),
(
element h3 {"About to ", xdmp:get-request-field("bulk-actions")},


if (xdmp:get-request-field("bulk-actions") eq "publish")
then ("PUBLISH ROUTINE HERE")
else if (xdmp:get-request-field("bulk-actions") eq "delete")
then (
(: DELETE ROUTINE :)
for $x in xdmp:get-request-field-names()
where ($x ne "bulk-actions") 
return xdmp:document-delete(xdmp:node-uri(ml-wp-data:get-wp-post-by-id($x cast as xs:integer)))

)
else ("ERROR - not sure what to do")


)
)