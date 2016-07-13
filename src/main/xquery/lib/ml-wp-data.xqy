xquery version "1.0-ml";

(: 
    XQuery / MarkLogic accessors for all the WordPress XML LOADED data
:)

module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data";

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

import module namespace consts = "http://www.xmlmachines.com/consts" at "/lib/consts.xqy"; 

(: We probably won't ever need to get the channel?
declare function ml-wp-data:get-channel() {
  $consts:IMPORT
}; :)

declare function ml-wp-data:get-authors() {
  fn:collection("authors")
};

declare function ml-wp-data:get-terms() {
  fn:collection("terms")
};

declare function ml-wp-data:get-categories() {
  fn:collection("categories")
};

declare function ml-wp-data:get-tags() {
  fn:collection("tags")
};

declare function ml-wp-data:get-items() {
  for $x in fn:collection("items")
  order by number($x//wp:post_id) descending  (: ascending :)
  return $x
};

declare function ml-wp-data:range-query($type as xs:string) {
    cts:element-values(xs:QName("wp:status"), (), ("collation=http://marklogic.com/collation/codepoint"), ml-wp-data:status-query($type)) 
};

(: TODO - refactor query out or parameterise - probably can be used in a lot of places :)
declare function ml-wp-data:range-query-recent-posts(){
cts:search(doc(),
  cts:and-query((
    cts:element-value-query(xs:QName("wp:post_type"), "post"),
    cts:element-value-query(xs:QName("wp:status"), "publish")
  )),
  ( cts:index-order(cts:element-reference(xs:QName("wp:post_id")), "descending") )
)
};

declare function ml-wp-data:status-query($type as xs:string) as cts:query {
    cts:and-query(( 
        cts:element-value-query(xs:QName("wp:post_type"), $type), 
        cts:collection-query(("items")) 
    ))
};

declare function ml-wp-data:type-query($type as xs:string, $estimate as xs:boolean) as item()* {
    if ($estimate)
    then ( xdmp:estimate( cts:search(fn:doc(), ml-wp-data:status-query($type)) )) 
    else ( cts:search(fn:doc(), ml-wp-data:status-query($type)) )
};

declare function ml-wp-data:get-media() {ml-wp-data:type-query("attachment", false())};
declare function ml-wp-data:get-pages() {ml-wp-data:type-query("page", false())};
declare function ml-wp-data:get-posts($filter as xs:string?) {ml-wp-data:type-query("post", false())};
declare function ml-wp-data:get-total-media() {ml-wp-data:type-query("attachment", true())};
declare function ml-wp-data:get-total-pages() {ml-wp-data:type-query("page", true())};
declare function ml-wp-data:get-total-posts() {ml-wp-data:type-query("post", true())};


(: TODO - the two xpath fns below need to be sorted for calls to data in ML rather than from the WP Exported XML file :)
declare function ml-wp-data:get-comments() {
    cts:search(fn:doc(), 
        cts:and-query(( cts:element-query(xs:QName("wp:comment"), cts:and-query(())), cts:collection-query(("items")) ))              
    )//wp:comment
};

declare function ml-wp-data:get-wp-post-ids() as xs:integer* {
    ml-wp-data:get-items()/wp:post_id
};

declare function ml-wp-data:get-highest-post-id() as xs:double {
    max(//wp:post_id)
};

declare function ml-wp-data:get-highest-term-id() as xs:double {
    max(//wp:term_id)
};

(: pages and posts both have a wp:post_id - this will grab either - NOTE this returns a document-node not an element :)
declare function ml-wp-data:get-wp-post-by-id($id as xs:integer) as document-node() {
  (: ml-wp-data:get-items()/wp:post_id[. = $id]/.. :)
  
  if($id = 0)
  (: TODO - this is going to cause problems as other pieces of code are updated! :)
  then (ml-wp-data:new-post-xml(0, "", "", ""))
  else (
    (: TODO - this is really nasty - at the moment I'm not managing IDs at all - you can import a couple of basic pages with the same ID and it'll return a sequence of items - I'm just returning the first one here... Not elegant - but it works for now.... :)

    cts:search(fn:doc(), 
          cts:and-query(( cts:element-value-query(xs:QName("wp:post_id"), string($id)), cts:collection-query(("items")) ))              
      )[1]
  )
};

(: TODO - had to slacken the document-node() return type; we don't really have a proper mechanism for handling WP users - this is necessary! :)
declare function ml-wp-data:get-author-by-username($username as xs:string) as document-node()? {

   (: TODO - there are  apparent conditions where authors are not listed - a bug? or simply user restrictions in WP? - I need to figure out how this happens :)
   
   if(collection("authors"))
   then (
       cts:search(fn:doc(), 
        cts:and-query(( cts:element-value-query(xs:QName("wp:author_login"), string($username)), cts:collection-query(("authors")) ))              
    )
   )
   (: else we can't do anything because no author data was imported TODO / FIXME :)
   else()
   
};

declare function ml-wp-data:get-author-first-and-last-name-from-username($name as xs:string) as xs:string {
    let $x := ml-wp-data:get-author-by-username($name)
    return if ($x) 
    then (
        if (not(($x//wp:author_first_name)/node()))
        then($x//wp:author_display_name)
        else(string($x//wp:author_first_name) || " " || string($x/wp:author_last_name))    
    )
    else ("TODO - NOAUTHOR")
};

declare function ml-wp-data:get-posts-by-authorname($username as xs:string) {
  cts:search(doc()/item, 
        cts:and-query(( cts:element-value-query(xs:QName("dc:creator"), string($username)), cts:collection-query(("items")) ))              
    )
};

declare function ml-wp-data:get-user-first-and-last-name-from-username($name as xs:string) as xs:string {
    ml-wp-data:get-author-first-and-last-name-from-username($name)
};

declare function ml-wp-data:new-post-xml($id as xs:double, $status as xs:string, $title as xs:string, $content as xs:string){
(:  figure out how to deal with users - I currently have no user code in place and deal with the post date - is it the point where the publish button is pressed?  I suspect so... :)
(: first id you edit is 4; second is 6; - HOW? :)
(: The process (how WP does it)

- As soon as you create a new post, a doc (assuming a clean WP install - this will have an ID of 4) gets saved to the database it seems to be an "auto-draft"
- As you then save the doc, 

:)

(:
Transition:

mysql> select * from wp_posts where id = 4;
+----+-------------+---------------------+---------------------+--------------+------------+--------------+-------------+----------------+-------------+---------------+-----------+---------+--------+---------------------+---------------------+-----------------------+-------------+-----------------------+------------+-----------+----------------+---------------+
| ID | post_author | post_date           | post_date_gmt       | post_content | post_title | post_excerpt | post_status | comment_status | ping_status | post_password | post_name | to_ping | pinged | post_modified       | post_modified_gmt   | post_content_filtered | post_parent | guid                  | menu_order | post_type | post_mime_type | comment_count |
+----+-------------+---------------------+---------------------+--------------+------------+--------------+-------------+----------------+-------------+---------------+-----------+---------+--------+---------------------+---------------------+-----------------------+-------------+-----------------------+------------+-----------+----------------+---------------+
|  4 |           1 | 2014-08-29 05:35:34 | 0000-00-00 00:00:00 |              | Auto Draft |              | auto-draft  | open           | open        |               |           |         |        | 2014-08-29 05:35:34 | 0000-00-00 00:00:00 |                       |           0 | http://localhost/?p=4 |          0 | post      |                |             0 |
+----+-------------+---------------------+---------------------+--------------+------------+--------------+-------------+----------------+-------------+---------------+-----------+---------+--------+---------------------+---------------------+-----------------------+-------------+-----------------------+------------+-----------+----------------+---------------+
1 row in set (0.00 sec)

mysql> select * from wp_posts where id = 4;
+----+-------------+---------------------+---------------------+--------------+------------+--------------+-------------+----------------+-------------+---------------+-----------+---------+--------+---------------------+---------------------+-----------------------+-------------+-----------------------+------------+-----------+----------------+---------------+
| ID | post_author | post_date           | post_date_gmt       | post_content | post_title | post_excerpt | post_status | comment_status | ping_status | post_password | post_name | to_ping | pinged | post_modified       | post_modified_gmt   | post_content_filtered | post_parent | guid                  | menu_order | post_type | post_mime_type | comment_count |
+----+-------------+---------------------+---------------------+--------------+------------+--------------+-------------+----------------+-------------+---------------+-----------+---------+--------+---------------------+---------------------+-----------------------+-------------+-----------------------+------------+-----------+----------------+---------------+
|  4 |           1 | 2014-08-29 05:40:43 | 0000-00-00 00:00:00 |              | draft      |              | draft       | open           | open        |               |           |         |        | 2014-08-29 05:40:43 | 2014-08-29 05:40:43 |                       |           0 | http://localhost/?p=4 |          0 | post      |                |             0 |
+----+-------------+---------------------+---------------------+--------------+------------+--------------+-------------+----------------+-------------+---------------+-----------+---------+--------+---------------------+---------------------+-----------------------+-------------+-----------------------+------------+-----------+----------------+---------------+

mysql> select * from wp_posts where id = 4;
+----+-------------+---------------------+---------------------+--------------+------------+--------------+-------------+----------------+-------------+---------------+-----------+---------+--------+---------------------+---------------------+-----------------------+-------------+-----------------------+------------+-----------+----------------+---------------+
| ID | post_author | post_date           | post_date_gmt       | post_content | post_title | post_excerpt | post_status | comment_status | ping_status | post_password | post_name | to_ping | pinged | post_modified       | post_modified_gmt   | post_content_filtered | post_parent | guid                  | menu_order | post_type | post_mime_type | comment_count |
+----+-------------+---------------------+---------------------+--------------+------------+--------------+-------------+----------------+-------------+---------------+-----------+---------+--------+---------------------+---------------------+-----------------------+-------------+-----------------------+------------+-----------+----------------+---------------+
|  4 |           1 | 2014-08-29 05:41:29 | 2014-08-29 05:41:29 |              | draft      |              | publish     | open           | open        |               | draft     |         |        | 2014-08-29 05:41:29 | 2014-08-29 05:41:29 |                       |           0 | http://localhost/?p=4 |          0 | post      |                |             0 |
+----+-------------+---------------------+---------------------+--------------+------------+--------------+-------------+----------------+-------------+---------------+-----------+---------+--------+---------------------+---------------------+-----------------------+-------------+-----------------------+------------+-----------+----------------+---------------+

:)

(: TODO - is there a pubdate if the article is a draft? :)
let $timestamp := fn:format-dateTime(fn:current-dateTime(), $consts:XML-DATETIME)
let $mysqltimestamp := fn:format-dateTime(fn:current-dateTime(), $consts:SQL-DATETIME)
return
document {
<item>
    <title>{$title}</title>
    <link>http://localhost/?p=4 - TODO</link>
    <pubDate>{$timestamp}</pubDate>
    <dc:creator>admin</dc:creator>
    <guid isPermaLink="false">http://localhost/?p=4 - TODO</guid>
    <description/>
    <content:encoded>{$content}</content:encoded>
    <excerpt:encoded/>
    <wp:post_id>{$id}</wp:post_id>
    <wp:post_date>{$mysqltimestamp}</wp:post_date>
    <wp:post_date_gmt>{$mysqltimestamp}</wp:post_date_gmt>
    <wp:comment_status>open</wp:comment_status>
    <wp:ping_status>open</wp:ping_status>
    <wp:post_name/>
    <wp:status>{$status}</wp:status>
    <wp:post_parent>0</wp:post_parent>
    <wp:menu_order>0</wp:menu_order>
    <wp:post_type>post</wp:post_type>
    <wp:post_password/>
    <wp:is_sticky>0</wp:is_sticky>
    <category domain="category" nicename="uncategorized">Uncategorized</category>
    <wp:postmeta>
        <wp:meta_key>_edit_last</wp:meta_key>
        <wp:meta_value>1</wp:meta_value>
    </wp:postmeta>
</item> }
};

(: TODO - original plan was to return this as JSON - Unfortunately WP XML export source is not valid JSON!! 
   Turns out it's the PHP Serialised format - which looks a little like JSON but isn't... :)
declare function ml-wp-data:get-media-attachment-metadata($id as xs:string) as item()* {
    doc($id)//wp:postmeta[wp:meta_key eq "_wp_attachment_metadata"]/wp:meta_value/node()
};

(: As the XML text() containing this metadata is serialised PHP, there's no easy way of parsing it - using tokenize and grabbing the values I need for now :)
declare function ml-wp-data:get-media-width-and-height($id as xs:string){
  let $i := tokenize(tokenize(ml-wp-data:get-media-attachment-metadata($id),'\{')[2],";")
  return (substring-after($i[2],":"), substring-after($i[4],":"))
};

declare function ml-wp-data:image-is-portrait($id as xs:string) {
    if(ml-wp-data:get-media-width-and-height($id)[2] gt ml-wp-data:get-media-width-and-height($id)[1]) then(attribute class {"portrait"}) else()
};
