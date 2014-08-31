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
            view-tools:success-notification((element span {attribute class { "glyphicon glyphicon-ok mr1e"}, " "},  element strong {"Document updated"}, 
                        " TODO - provide more information about what was just updated"), true() )
        )
        else ()}
        <div class="row">
            <div class="col-sm-4">    
                {view-tools:summary-widget("At a Glance")}    
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
            
            <div class="col-sm-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                      <h3 class="panel-title">Quick Draft</h3>
                    </div>
                    <div class="panel-body">
                        
                        <form id="editor" class="form-horizontal" role="form">
                            <input style="margin-bottom:1em;" class="form-control input-block-level" type="text" placeholder="Post Title" />
                            <textarea style="margin-bottom:1em; height:12em;" class="form-control">What's on your mind</textarea>
                            <button class="btn btn-primary"  type="submit"><span class="glyphicon glyphicon-save mr1e">{" "}</span>Save Draft</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>)