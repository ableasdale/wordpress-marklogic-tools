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

view-tools:create-wp-admin-html-page("Admin Dashboard", (),        
    <div id="dashboard" class="row">     
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
                        <h4>Recently published</h4>
                        {view-tools:recently-published-widget(5)}
                        <h4>Comments</h4>
                    </div>
                </div>
            </div> 
            
            <div class="col-sm-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                      <h3 class="panel-title">Quick Draft</h3>
                    </div>
                    <div class="panel-body">
                        
                        <form action="/wp-admin/update.xqy" method="post" class="form-horizontal" role="form">
                            
                            <div style="margin-bottom:1em;" class="input-group">
                                <span class="input-group-addon">Title</span>
                                <input name="title" class="form-control" type="text" placeholder="Your Post Title" />
                            </div>
                            
                            <label for="article">Article body:</label>
                            <textarea style="margin-bottom:1em; height:12em;" name="article" class="form-control">{" "}</textarea>
                            
                            <input type="hidden" name="id" value="0" />
                            <input type="hidden" name="status" value="draft" />
                            <input type="hidden" name="type" value="item" />
                            <button class="btn btn-primary" type="submit"><span class="glyphicon glyphicon-save mr1e">{" "}</span>Save Draft</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>)