xquery version "1.0-ml";

(: Recreate the original Wordpress doc from what is now stored in MarkLogic - TODO - the main parts - blog title, link etc are currently not handled and are hard-coded! :)

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

xdmp:set-response-content-type("text/xml; charset=utf-8"), xdmp:add-response-header("Content-Disposition", fn:concat("attachment; filename=", "TODO.xml")), (
<!-- This is a WordPress eXtended RSS file generated by WordPress as an export of your site. -->,
<!-- It contains information about your site's posts, pages, comments, categories, and other content. -->,
<!-- You may use this file to transfer that content from one site to another. -->,
<!-- This file is not intended to serve as a complete backup of your site. -->,

<!-- To import this information into a WordPress site follow these steps: -->,
<!-- 1. Log in to that site as an administrator. -->,
<!-- 2. Go to Tools: Import in the WordPress admin panel. -->,
<!-- 3. Install the "WordPress" importer from the list. -->,
<!-- 4. Activate & Run Importer. -->,
<!-- 5. Upload this file using the form provided on that page. -->,
<!-- 6. You will first be asked to map the authors in this export file to users -->,
<!--    on the site. For each author, you may choose to map to an -->,
<!--    existing user on the site or to create a new user. -->,
<!-- 7. WordPress will then import each of the posts, pages, comments, categories, etc. -->,
<!--    contained in this file into your site. -->,

<rss version="2.0"
	xmlns:excerpt="http://wordpress.org/export/1.2/excerpt/"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	xmlns:wfw="http://wellformedweb.org/CommentAPI/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:wp="http://wordpress.org/export/1.2/">

<channel>
	<title>The Middle East Magazine</title>
	<link>http://www.themiddleeastmagazine.com/wp-mideastmag-live</link>
	<description>Published since 1974, The Middle East is well established as the region&#039;s bestselling pan-Arab magazine in English. It provides an expert commentary on wide ranging issues in the Arab World.</description>
	<pubDate>Thu, 21 Aug 2014 15:15:21 +0000</pubDate>
	<language>en-US</language>
	<wp:wxr_version>1.2</wp:wxr_version>
	<wp:base_site_url>http://www.themiddleeastmagazine.com/wp-mideastmag-live</wp:base_site_url>
	<wp:base_blog_url>http://www.themiddleeastmagazine.com/wp-mideastmag-live</wp:base_blog_url>

    {ml-wp-data:get-authors()}
    {ml-wp-data:get-categories()}
    {ml-wp-data:get-terms()}
    {ml-wp-data:get-items()}

</channel>
</rss>)