xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 

import module namespace wp-export-data = "http://www.xmlmachines.com/wp-export-data" at "/lib/wp-export-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

declare variable $id as xs:integer := xdmp:get-request-field("id") cast as xs:integer;

xdmp:set-response-content-type("text/html; charset=utf-8"),
("<!DOCTYPE html>",
<html>
<head>
    <script src="https://tinymce.cachefly.net/4.1/tinymce.min.js">{" "}</script>
    <script language="javascript" type="text/javascript">
        <![CDATA[tinymce.init({selector:'textarea'});]]>
    </script>
</head>

<body>
    <textarea>{wp-export-data:get-wp-post-by-id($id)/content:encoded}</textarea>    
</body>
</html>
)
