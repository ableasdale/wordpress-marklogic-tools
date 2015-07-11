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

(:
declare variable $DIRECTORIES as xs:string+ := ("E:\wordpress-marklogic\", "E:\work\wordpress-marklogic-tools\sample-exports");
:)

declare variable $JAVA-CLASSPATH := xdmp:getenv("CLASSPATH");
declare variable $EXPORT-FILENAME-DATETIME as xs:string := "[Y0001][M01][D01]-[H01][m01][s01]";
declare variable $XML-DATETIME as xs:string := "[FNn,*-3], [D01] [MNn,*-3] [Y0001] [H01]:[m01]:[s01]"; 
(: TODO - I think wordpress is choking on the BST time modifier here (+1) 
declare variable $XML-DATETIME as xs:string := "[FNn,*-3], [D01] [MNn,*-3] [Y0001] [H01]:[m01]:[s01] [Z]"; :)
declare variable $SQL-DATETIME as xs:string := "[Y0001]-[M01]-[D01] [H01]:[m01]:[s01]";
declare variable $CONFIG-DOC-URI as xs:string := "/app-configuration.xml";
declare variable $DIRECTORIES as xs:string+ := ("/home/alexb/workspace/wordpress-marklogic-tools/sample-exports");
(: declare variable $DIRECTORIES as xs:string+ := ("E:\workspace\wordpress-marklogic-tools\sample-exports");  :)