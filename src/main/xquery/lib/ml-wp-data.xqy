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
  fn:collection("items")
};

declare function ml-wp-data:get-pages() {
    cts:search(fn:doc(), 
        cts:and-query(( cts:element-value-query(xs:QName("wp:post_type"), "page"), cts:collection-query(("items")) ))              
    )
};

declare function ml-wp-data:get-posts() {
    cts:search(fn:doc(), 
        cts:and-query(( cts:element-value-query(xs:QName("wp:post_type"), "post"), cts:collection-query(("items")) ))              
    )
};

(: TODO - the two xpath fns below need to be sorted for calls to data in ML rather than from the WP Exported XML file :)
declare function ml-wp-data:get-comments() {
  ml-wp-data:get-items()//wp:comment 
};

declare function ml-wp-data:get-wp-post-ids() as xs:integer* {
  ml-wp-data:get-items()/wp:post_id
};

(: pages and posts both have a wp:post_id - this will grab either - NOTE this returns a document-node not an element :)
declare function ml-wp-data:get-wp-post-by-id($id as xs:integer) as document-node() {
  (: ml-wp-data:get-items()/wp:post_id[. = $id]/.. :)
  cts:search(fn:doc(), 
        cts:and-query(( cts:element-value-query(xs:QName("wp:post_id"), string($id)), cts:collection-query(("items")) ))              
    )
};