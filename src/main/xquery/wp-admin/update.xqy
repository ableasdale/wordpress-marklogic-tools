xquery version "1.0-ml";

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

(: Note - this will break if ML ever remove this! :)
import module namespace mem = "http://xqdev.com/in-mem-update" at "/MarkLogic/appservices/utils/in-mem-update.xqy";

declare variable $uri as xs:string :=  xdmp:get-request-field("uri");
declare variable $title as xs:string := xdmp:get-request-field("title");
declare variable $article as xs:string := xdmp:get-request-field("article");
declare variable $doc as document-node() := fn:doc($uri);

    (: let $_ := xdmp:log($doc//title)
    let $_ := xdmp:log($title) :)
(    
    let $node := mem:node-replace($doc//title, element title {$title})
    let $node := mem:node-replace($node//content:encoded, element content:encoded {$article}) 
    return xdmp:node-replace($doc, $node),
    xdmp:redirect-response("/wp-admin/dashboard.xqy?msg=updated")   
)