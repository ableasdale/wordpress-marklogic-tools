xquery version "1.0-ml";

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

(: Note - this will break if ML ever remove this! :)
import module namespace mem = "http://xqdev.com/in-mem-update" at "/MarkLogic/appservices/utils/in-mem-update.xqy";
import module namespace consts = "http://www.xmlmachines.com/consts" at "/lib/consts.xqy"; 
import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

declare variable $id as xs:integer := xdmp:get-request-field("id") cast as xs:integer;
declare variable $uri as xs:string :=  xdmp:get-request-field("uri");
declare variable $type as xs:string := xdmp:get-request-field("type", "");

declare variable $title as xs:string := xdmp:get-request-field("title");
declare variable $status as xs:string := xdmp:get-request-field("status");
declare variable $article as xs:string := xdmp:get-request-field("article");
declare variable $doc as document-node() := fn:doc($uri);

declare function local:process-item() {
if ($id eq 0)
then (
    (: This is a new doc :)
    let $x:= ml-wp-data:new-post-xml((ml-wp-data:get-highest-post-id() + 1), $status, $title, $article)
    return (xdmp:document-insert(fn:concat("/",xdmp:md5(xdmp:quote($x)),".xml"), $x, (), "items" ),
    xdmp:redirect-response("/wp-admin/dashboard.xqy?msg=created"))   
)
else (    
    (: This is a pre-existing doc - so make the necessary updates :)
    let $node := mem:node-replace($doc//title, element title {$title})
    let $node := mem:node-replace($node//wp:status, element wp:status {$status})
    let $node := mem:node-replace($node//content:encoded, element content:encoded {$article}) 
    return xdmp:node-replace($doc, $node),
    xdmp:redirect-response("/wp-admin/dashboard.xqy?msg=updated")   
)
};

declare function local:process-category() {
(: TODO - at the moment the slug is generated - this won't be replaced if a slug is manually entered :)

let $x := <wp:category>
    <wp:term_id>{ml-wp-data:get-highest-term-id() + 1}</wp:term_id>
    <wp:category_nicename>{fn:lower-case(fn:replace($title, " ", "-"))}</wp:category_nicename>
    <wp:category_parent />
    <wp:cat_name>{$title}</wp:cat_name>
    <wp:category_description>{$article}</wp:category_description>
</wp:category>

return (xdmp:document-insert(fn:concat("/",xdmp:md5(xdmp:quote($x)),".xml"), $x, (), "categories" ),
    xdmp:redirect-response("/wp-admin/categories.xqy?msg=created"))   
};

declare function local:process-tag() {
(: TODO - this isn't wired in :)
let $x := 
<wp:tag>
    <wp:term_id>{ml-wp-data:get-highest-term-id() + 1}</wp:term_id>
    <wp:tag_slug>{fn:lower-case(fn:replace($title, " ", "-"))}</wp:tag_slug>
    <wp:tag_name>{$title}</wp:tag_name>
    <wp:tag_description>do people really describe tags?</wp:tag_description>
</wp:tag>
return $x
};
	
declare function local:process-configuration() {
	let $email-address := xdmp:get-request-field("email-address")
	let $node := mem:node-replace($doc//title, element title {xdmp:get-request-field("title")})
	let $node := mem:node-replace($node//description, element description {xdmp:get-request-field("tagline")})
	let $node := mem:node-replace($node//wp:base_blog_url, element wp:base_blog_url {xdmp:get-request-field("wp-address-url")})
	let $node := mem:node-replace($node//wp:base_site_url, element wp:base_site_url {xdmp:get-request-field("wp-site-url")})
    return (xdmp:document-insert($consts:CONFIG-DOC-URI, $node), xdmp:redirect-response("/wp-admin/dashboard.xqy?msg=updated"))	
};

(: Is it an item, a category or other? :)
if ($type eq "item")
then (local:process-item())
else if ($type eq "category")
then (local:process-category())
else if ($type eq "tag")
then (local:process-tag())
else if ($type eq "configuration")
then (local:process-configuration())
else ("Updates for that datatype are either supported in this release or something went wrong..")
