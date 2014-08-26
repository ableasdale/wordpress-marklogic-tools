xquery version "1.0-ml";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";
(: import module namespace consts = "http://www.xmlmachines.com/consts" at "/lib/consts.xqy"; :)

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

declare variable $message := xdmp:get-request-field("msg");

view-tools:create-wp-admin-html-page("Dashboard", (),        
    <div id="dashboard">     
        {if (not(empty(xdmp:get-server-field("filename")))) 
        then (view-tools:info-notification( (<strong>Filename is currently set: </strong> || xdmp:get-server-field("filename")), false() ) )
        else ()
        }
        {if (fn:string-length($message) > 0)
        then (
            view-tools:success-notification((element strong {"Document updated"}, 
                        " TODO - provide more information about what was just updated"), true() )
        )
        else ()}
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                      <h3 class="panel-title">At a Glance</h3>
                    </div>
                    <div class="panel-body">
                        <p><a href="/wp-admin/posts.xqy"><span class="badge">{fn:count(ml-wp-data:get-posts())}</span> Posts</a></p>
                        <p>TODO - how many published/pending etc..</p>     
                        <p><a href="/wp-admin/pages.xqy"><span class="badge">{fn:count(ml-wp-data:get-pages())}</span> Pages</a></p>
                        <p><a href="/wp-admin/comments.xqy"><span class="badge">{fn:count(ml-wp-data:get-comments())}</span> Comments</a></p>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                      <h3 class="panel-title">Activity</h3>
                    </div>
                    <div class="panel-body">
                        <p>Recently published</p>
                        <p>Comments</p>
                    </div>
                </div>
            </div>
            
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                      <h3 class="panel-title">Quick Draft</h3>
                    </div>
                    <div class="panel-body">
                        <input />
                        <textarea />
                    </div>
                </div>
            </div>
        </div>
    </div>)