xquery version "1.0-ml";

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

import module namespace wp-export-data = "http://www.xmlmachines.com/wp-export-data" at "/lib/wp-export-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";


(:
for $i in xdmp:document-get("/tmp/wordpress-marklogic-tools/sample-exports/export-from-default-install-wp4b4-with-6-users-basic-content-tags-and-categories.xml")/rss/channel/node()
return local-name($i)
:)

(: stuff at the start :)

(
(: insert authors - TODO - check first to see whether this user already exists - otherwise you're going to break! :)
for $x in wp-export-data:get-authors() return (xdmp:document-insert(fn:concat("/",xdmp:md5(xdmp:quote($x)),".xml"), $x, (), "authors" ), "1 author loaded ok"), 
(: insert categories :)
for $x in wp-export-data:get-categories() return (xdmp:document-insert(fn:concat("/",xdmp:md5(xdmp:quote($x)),".xml"), $x, (), "categories" ), "1 category loaded ok"),
(: insert tags :)
for $x in wp-export-data:get-tags() return (xdmp:document-insert(fn:concat("/",xdmp:md5(xdmp:quote($x)),".xml"), $x, (), "tags" ), "1 tag loaded ok"),
(: insert terms :)
for $x in wp-export-data:get-terms() return (xdmp:document-insert(fn:concat("/",xdmp:md5(xdmp:quote($x)),".xml"), $x, (), "terms" ), "1 term loaded ok"),
(: gen :)
(: insert items :)
for $x in wp-export-data:get-items() return (xdmp:document-insert(fn:concat("/",xdmp:md5(xdmp:quote($x)),".xml"), $x, (), "items" ), "1 item loaded ok")
)