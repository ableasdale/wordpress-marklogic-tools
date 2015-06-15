xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

view-tools:create-wp-admin-html-page("Media", 
(
<script src="/assets/js/phpUnserialize.js">{" "}</script>
), 
    <div id="posts" class="row">
        <h4>TODO filter by category, all dates, bulk actions etc... ALSO fix portrait oriented images by centering and add moment.js (lib aleady added). Then put in pagination so it retrieves a smaller number of images with each request.  Then make search work</h4>
        <form action="/wp-admin/bulk.xqy" method="post">

        <!-- TODO - bulk actions should be parameterised! -->
        <div class="well">
            <div class="form-group">
                <select class="form-control" name="bulk-actions">
                    <option value="-1">Bulk Actions...</option>
                    <option value="publish">Publish</option>
                    <option value="delete">Delete</option>
                </select>
                <input type="submit"/>
            </div>
        </div>

        <table class="table table-striped table-bordered">
            {view-tools:create-thead-element(("", "Thumbnail", "File", "Author", "Uploaded to", "Metadata Node", "W x H", "Comments", "Date"))}
            <!-- TODO - and parameterise this  -->
            <tbody>
                {
                    for $x in ml-wp-data:get-media()/*
                    order by number($x/wp:post_id) descending
                    return element tr {
                        (: if (fn:not($x/wp:status eq "publish"))
                        then (attribute class {"info"})
                        else (), :)
                        element td {element input { attribute type {"checkbox"}, attribute name {fn:string($x/wp:post_id)} }},
                        element td {
                        
                        (: TODO - make a summary page on clicking on image link that works in the same way that wordpress does ... 
                        element div { attribute class {"small-thumbnail"},
                        element a {element img {attribute class {"img-thumbnail"}, attribute src{$x/guid}}}
                        } :)
                        element div { attribute class {"small-thumbnail img-thumbnail"},
                            element a {attribute href {xdmp:node-uri($x)}, element img {ml-wp-data:image-is-portrait(xdmp:node-uri($x)), attribute src{$x/guid}}}
                            (: element img {attribute src{$x/guid}} :)
                        }
                        
                        
                        },
                        element td {string($x/wp:post_name)},                       
                       (: TODO - get author first and suranme from dc:creator:::  element td {string($x/wp:author_first_name) || " " || string($x/wp:author_last_name)}, :)
                        element td {ml-wp-data:get-author-first-and-last-name-from-username(string($x/dc:creator))},
                        (: ml-wp-data:get-media-attachment-metadata(xdmp:node-uri($x)) :)
                        element td {"TODO"},
                        element td {
                            element textarea { ml-wp-data:get-media-attachment-metadata(xdmp:node-uri($x)) }
                        },                        
                        element td {
                            ml-wp-data:get-media-width-and-height(xdmp:node-uri($x))
                        },
                        element td {attribute class {"text-center"}, view-tools:create-badge-link(fn:concat("/wp-admin/comments.xqy?id=","TODO"), string(fn:count($x/wp:comment)))},
                        element td {string($x/wp:post_date)}                       
                    }   
                }
            </tbody>
        </table>
        </form>
    </div>)


(:
<?xml version="1.0" encoding="UTF-8"?>
<item xmlns:excerpt="http://wordpress.org/export/1.2/excerpt/" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:wfw="http://wellformedweb.org/CommentAPI/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:wp="http://wordpress.org/export/1.2/">
    <title>portrait-img</title>
    <link>http://127.0.0.1:4001/wordpress/?attachment_id=75</link>
    <pubDate>Sat, 13 Jun 2015 20:33:01 +0000</pubDate>
    <dc:creator>admin</dc:creator>
    <guid isPermaLink="false">http://127.0.0.1:4001/wordpress/wp-content/uploads/2015/06/portrait-img.png</guid>
    <description/>
    <content:encoded/>
    <excerpt:encoded/>
    <wp:post_id>75</wp:post_id>
    <wp:post_date>2015-06-13 20:33:01</wp:post_date>
    <wp:post_date_gmt>2015-06-13 20:33:01</wp:post_date_gmt>
    <wp:comment_status>open</wp:comment_status>
    <wp:ping_status>open</wp:ping_status>
    <wp:post_name>portrait-img</wp:post_name>
    <wp:status>inherit</wp:status>
    <wp:post_parent>0</wp:post_parent>
    <wp:menu_order>0</wp:menu_order>
    <wp:post_type>attachment</wp:post_type>
    <wp:post_password/>
    <wp:is_sticky>0</wp:is_sticky>
    <wp:attachment_url>http://127.0.0.1:4001/wordpress/wp-content/uploads/2015/06/portrait-img.png</wp:attachment_url>
    <wp:postmeta>
      <wp:meta_key>_wp_attached_file</wp:meta_key>
      <wp:meta_value>2015/06/portrait-img.png</wp:meta_value>
    </wp:postmeta>
    <wp:postmeta>
      <wp:meta_key>_wp_attachment_metadata</wp:meta_key>
      <wp:meta_value>a:5:{s:5:"width";i:454;s:6:"height";i:800;s:4:"file";s:24:"2015/06/portrait-img.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:24:"portrait-img-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:24:"portrait-img-170x300.png";s:5:"width";i:170;s:6:"height";i:300;s:9:"mime-type";s:9:"image/png";}s:14:"post-thumbnail";a:4:{s:4:"file";s:24:"portrait-img-454x198.png";s:5:"width";i:454;s:6:"height";i:198;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:11:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";s:11:"orientation";i:0;}}</wp:meta_value>
    </wp:postmeta>
  </item>
:)