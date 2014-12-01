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
(: TODO - can we ensure that only items that are integer values come back - this is NASTY but it does work  :)
where (some $i in ("0","1","2","3","4","5","6","7","8","9") satisfies contains($x, $i) )


(:
declare function local:contains-alphabet-chars($arg as xs:string?)  as xs:boolean
{
    some $searchString in ("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")
    satisfies contains($arg,$searchString)
}; :)


(: return element p {$x}  :)
return xdmp:document-delete(xdmp:node-uri(ml-wp-data:get-wp-post-by-id($x cast as xs:integer)))

(: where ($x ne ("bulk-actions", "status" ))

:)
)
else ("ERROR - not sure what to do")


)
)