xquery version "1.0-ml";

(: 
    XQuery / MarkLogic accessors for all the WordPress XML Exported data
:)

module namespace consts = "http://www.xmlmachines.com/consts";

(:
declare variable $import as element(channel) := xdmp:document-get("E:\wordpress-marklogic\sample-exports\export-from-default-install-wp4b4-with-6-users-and-basic-content.xml")/rss/channel;
:)

declare variable $IMPORT as element(channel) := xdmp:document-get("E:\wordpress-marklogic\themiddleeastmagazine.wordpress.2014-08-21.xml")/rss/channel; 

(: declare variable $IMPORT as element(channel) := xdmp:document-get("E:\work\wordpress-marklogic-tools\sample-exports\export-from-default-install-wp4b4-with-6-users-basic-content-tags-and-categories.xml")/rss/channel; :) 