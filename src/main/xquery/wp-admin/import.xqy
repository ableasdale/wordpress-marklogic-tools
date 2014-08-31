xquery version "1.0-ml";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";
import module namespace consts = "http://www.xmlmachines.com/consts" at "/lib/consts.xqy"; 

declare namespace dir = "http://marklogic.com/xdmp/directory";
declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

declare variable $message := xdmp:get-request-field("msg");

view-tools:create-wp-admin-html-page("Import", (),        
    <div id="import">        

        <div class="bs-callout bs-callout-info">
            <h4>Important note about configuration</h4>
            <p>See <em>src/main/xquery/lib/consts.xqy</em> and add the directory name(s) to <strong>$DIRECTORIES</strong></p>
            <p>TODO - in a future release - consider archiving earlier content to another collection that can be moved back and fourth as necessary...</p>
        </div> 
  
  
        <div class="row">
            <div class="col-sm-4">
                {view-tools:summary-widget("Your Current Database")}
            </div>
            
            <div class="col-sm-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Available WordPress Export XML Files</h3>
                    </div>
                    <div class="panel-body">
                        <div class="list-group">
                            {for $fh in view-tools:get-export-directories()/dir:entry
                            return
                                element a {
                                    attribute href {concat("/wp-admin/import-wp-export-file.xqy?fname=", fn:encode-for-uri($fh/dir:pathname/text()))},
                                    attribute class { "list-group-item" },
                                    ($fh/dir:filename/text() || " " || "(" || fn:round(xs:unsignedLong($fh/dir:content-length/text()) div 1024) || " Kb)")
                                }
                            }
                        </div>                        
                    </div>
                </div>
            </div>
        </div>
    </div>)
    
    
             (: {if (fn:string-length($message) > 0)
        then (
           TODO - refactor this out into the view module - it can definitely be reused 
            element div {attribute class {"page-header"},
                element div {
                    attribute class {"alert alert-success"},
                    attribute role {"alert"},
                        element strong {"Document updated"}, 
                        " TODO - provide more information about what was just updated"                
                }
            })
        else ()} :)