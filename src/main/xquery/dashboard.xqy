xquery version "1.0-ml";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";
(: import module namespace consts = "http://www.xmlmachines.com/consts" at "/lib/consts.xqy"; :)

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

view-tools:create-wp-admin-html-page("Dashboard", (),        
    <div id="dashboard">
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                      <h3 class="panel-title">At a Glance</h3>
                    </div>
                    <div class="panel-body">
                        <p><a href="/posts.xqy">{fn:count(ml-wp-data:get-posts())} posts</a></p>
                        <p>TODO - how many published/pending etc..</p>     
                        <p><a href="/pages.xqy">{fn:count(ml-wp-data:get-pages())} pages</a></p>
                        <p>{fn:count(ml-wp-data:get-comments())} comments</p>
                    </div>
                </div>
            </div>
        </div>
    </div>)