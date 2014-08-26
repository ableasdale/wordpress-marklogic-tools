xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

view-tools:create-wp-admin-html-page("Posts", (),
    <div id="posts" class="page-header">
        <h3>TODO filter by category, all dates, bulk actions etc...</h3>
        <table class="table table-striped table-bordered">
            {view-tools:create-thead-element(("ID", "Title", "Status", "Author", "Categories", "Tags", "Comments", "Date"))}
            <!-- TODO - and parameterise this  -->
            <tbody>
                {
                    for $x in ml-wp-data:get-posts()/*
                    order by number($x/wp:post_id) ascending
                    return element tr {
                        element td {attribute class {"text-center"}, view-tools:create-badge-link(fn:concat("/wp-admin/editor.xqy?id=",fn:string($x/wp:post_id)), string($x/wp:post_id))},
                        element td {string($x/title)},
                        element td {string($x/wp:status)},                              
                       (: TODO - get author first and suranme from dc:creator:::  element td {string($x/wp:author_first_name) || " " || string($x/wp:author_last_name)}, :)
                        element td {ml-wp-data:get-author-first-and-last-name-from-username(string($x/dc:creator))},
                        element td {let $strs := for $i in $x/category[@domain = "category"] return $i/string() return fn:string-join($strs, ", ")},
                        element td {attribute class {"tags"}, 
                            let $strs := for $i in $x/category[@domain = "post_tag"] 
                            return view-tools:create-badge-link( fn:concat("/wp-admin/editor.xqy?id=", $i/string()), $i/string()) 
                            return $strs
                        },
                        element td {attribute class {"text-center"}, view-tools:create-badge-link(fn:concat("/wp-admin/comments.xqy?id=","TODO"), string(fn:count($x/wp:comment)))},
                        element td {string($x/wp:post_date)}
                    }   
                }
            </tbody>
        </table>
    </div>)












(:

<item>
        <title>Hello world!</title>
    <link>http://localhost:8080/wordpress/?p=1</link>
    <pubDate>Thu, 21 Aug 2014 12:19:53 +0000</pubDate>
    <dc:creator>wp-admin</dc:creator>
    <guid isPermaLink="false">http://localhost:8080/wordpress/?p=1</guid>
    <description/>
    <content:encoded>Welcome to WordPress. This is your first post. Edit or delete it, then start blogging!</content:encoded>
    <excerpt:encoded/>
    <wp:post_id>1</wp:post_id>
    <wp:post_date>2014-08-21 12:19:53</wp:post_date>
    <wp:post_date_gmt>2014-08-21 12:19:53</wp:post_date_gmt>
    <wp:comment_status>open</wp:comment_status>
    <wp:ping_status>open</wp:ping_status>
    <wp:post_name>hello-world</wp:post_name>
    <wp:status>publish</wp:status>
    <wp:post_parent>0</wp:post_parent>
    <wp:menu_order>0</wp:menu_order>
    <wp:post_type>post</wp:post_type>
    <wp:post_password/>
    <wp:is_sticky>0</wp:is_sticky>
    <category domain="category" nicename="uncategorised">Uncategorised</category>
    <wp:comment>
      <wp:comment_id>1</wp:comment_id>
      <wp:comment_author>Mr WordPress</wp:comment_author>
      <wp:comment_author_email/>
      <wp:comment_author_url>https://wordpress.org/</wp:comment_author_url>
      <wp:comment_author_IP/>
      <wp:comment_date>2014-08-21 12:19:53</wp:comment_date>
      <wp:comment_date_gmt>2014-08-21 12:19:53</wp:comment_date_gmt>
      <wp:comment_content>Hi, this is a comment.
To delete a comment, just log in and view the post&amp;#039;s comments. There you will have the option to edit or delete them.</wp:comment_content>
      <wp:comment_approved>1</wp:comment_approved>
      <wp:comment_type/>
      <wp:comment_parent>0</wp:comment_parent>
      <wp:comment_user_id>0</wp:comment_user_id>
    </wp:comment>
    <wp:comment>
      <wp:comment_id>2</wp:comment_id>
      <wp:comment_author>Foo Bar</wp:comment_author>
      <wp:comment_author_email>foo@example.com</wp:comment_author_email>
      <wp:comment_author_url>http://example.com</wp:comment_author_url>
      <wp:comment_author_IP>::1</wp:comment_author_IP>
      <wp:comment_date>2014-08-21 15:03:58</wp:comment_date>
      <wp:comment_date_gmt>2014-08-21 14:03:58</wp:comment_date_gmt>
      <wp:comment_content>Additional comment added</wp:comment_content>
      <wp:comment_approved>1</wp:comment_approved>
      <wp:comment_type/>
      <wp:comment_parent>0</wp:comment_parent>
      <wp:comment_user_id>2</wp:comment_user_id>
    </wp:comment>
  </item>
:)