xquery version "1.0-ml";

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

import module namespace wp-export-data = "http://www.xmlmachines.com/wp-export-data" at "lib/wp-export-data.xqy";

declare variable $import as element(channel) := xdmp:document-get("E:\wordpress-marklogic\sample-exports\export-from-default-install-wp4b4-with-6-users-and-basic-content.xml")/rss/channel;

xdmp:set-response-content-type("text/html; charset=utf-8"),
("<!DOCTYPE html>",
<html>
<body>
    <h2>Dashboard</h2>
    <div id="at-a-glance">
        <h3>At a glance widget</h3>
        <p>{fn:count(wp-export-data:get-posts())} posts</p>
        <p>TODO - how many published/pending etc..</p>     
        <p>{fn:count(wp-export-data:get-pages())} pages</p>
        <p>{fn:count(wp-export-data:get-comments())} comments</p>
    </div>
</body>
</html>
)