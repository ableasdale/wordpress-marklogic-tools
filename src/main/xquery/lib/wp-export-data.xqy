xquery version "1.0-ml";

(: 
    XQuery / MarkLogic accessors for all the WordPress XML Exported data
:)

module namespace wp-export-data = "http://www.xmlmachines.com/wp-export-data";

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

declare variable $import as element(channel) := xdmp:document-get("E:\work\wordpress-marklogic-tools\sample-exports\export-from-default-install-wp4b4-with-6-users-basic-content-tags-and-categories.xml")/rss/channel;

declare function wp-export-data:get-channel() {
  $import
};

declare function wp-export-data:get-authors() {
  wp-export-data:get-channel()/wp:author
};

declare function wp-export-data:get-terms() {
  wp-export-data:get-channel()/wp:term
};

declare function wp-export-data:get-categories() {
  wp-export-data:get-channel()/wp:category
};

declare function wp-export-data:get-items() {
  wp-export-data:get-channel()/item
};

declare function wp-export-data:get-pages() {
  wp-export-data:get-items()/wp:post_type[. = 'page']/..  (: [//wp:post_type/string() = 'page'] :)
};

declare function wp-export-data:get-posts() {
  wp-export-data:get-items()/wp:post_type[. = 'post']/.. (: [//wp:post_type/string() = 'page'] :)
};

declare function wp-export-data:get-comments() {
  wp-export-data:get-items()//wp:comment 
};

declare function wp-export-data:get-wp-post-ids() as xs:integer* {
  wp-export-data:get-items()/wp:post_id
};

(: pages and posts both have a wp:post_id - this will grab either :)
declare function wp-export-data:get-wp-post-by-id($id as xs:integer) {
  wp-export-data:get-items()/wp:post_id[. = $id]/..
};