xquery version "1.0-ml";

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";


declare function local:get-channel() {
  $consts:IMPORT
};

declare function local:get-authors() {
  local:get-channel()/wp:author
};

declare function local:get-terms() {
  local:get-channel()/wp:term
};

declare function local:get-categories() {
  local:get-channel()/wp:category
};

declare function local:get-items() {
  local:get-channel()/item
};

declare function local:get-pages() {
  local:get-items()/wp:post_type[. = 'page']/..  (: [//wp:post_type/string() = 'page'] :)
};

declare function local:get-posts() {
  local:get-items()/wp:post_type[. = 'post']/.. (: [//wp:post_type/string() = 'page'] :)
};

declare function local:get-wp-post-ids() as xs:integer* {
  local:get-items()/wp:post_id
};

(: pages and posts both have a wp:post_id - this will grab either :)
declare function local:get-wp-post-by-id($id as xs:integer) {
  local:get-items()/wp:post_id[. = $id]/..
};

(:
local:get-channel() :)

(: local:get-wp-post-ids() :)

local:get-channel()

