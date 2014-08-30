xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

declare variable $id as xs:integer := xdmp:get-request-field("id", "0") cast as xs:integer;

declare variable $item as element(item) := ml-wp-data:get-wp-post-by-id($id)/node();

(: TODO - skanky handling if you don't pass in an id - trigger a nice error message :)

view-tools:create-wp-admin-html-page("Editor", view-tools:get-tiny-mce-js(),
    <div id="editor">
        {if ($id eq 0)
         then ( view-tools:warning-notification( " You are currently creating a new post.", true()) )
         else ( view-tools:info-notification ( (element strong {"Notice "}, "You are currently editing a post with the status of ", element strong {$item/wp:status/string()}, " with the post id ", fn:concat("#", $id, ":&quot;", $item/title/string(),"&quot;") ), false()) )
        }
        <p>debug: {ml-wp-data:get-highest-post-id()}</p>    
            
        <div class="page-header">
            <form class="form-horizontal" action="/wp-admin/update.xqy" method="post">
                
                
                <div class="input-group">
                    <span class="input-group-addon">Title</span>
                    {element input {
                            attribute class {"form-control"},
                            attribute name {"title"},
                            attribute value {$item/title/string()}
                        }             
                    }                    
                </div>
                
                <!-- div class="form-group">
                    <label for="title" class="control-label col-xs-2">Title</label>
                    <div class="col-xs-10">
                        {element input {
                                attribute class {"form-control"},
                                attribute name {"title"},
                                attribute value {$item/title/string()}
                            }             
                        }         
                    </div>
                </div -->
               
                <p>TODO: No permalink impl, No Media Library integration, No HTML Source view</p>
    
                <div class="form-group">
                    <textarea name="article">{$item/content:encoded}</textarea>
                </div>
                
                <div class="form-group">
                    <!-- "col-xs-offset-2 col-xs-10" -->
                    <div class="col-xs-10">
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </div>
                {element input {
                    attribute type {"hidden"},
                    attribute name {"uri"},
                    attribute value {xdmp:node-uri($item)}
                }}
            </form>
                
    
            <!-- form class="well form-search">
        <input type="text" class="input-medium search-query"/>
        <button type="submit" class="btn btn-primary">Search</button>
      </form -->
    
    
                <!-- EXAMPLES form class="form-horizontal">
                

        
        <div class="form-group">
            <label for="inputPassword" class="control-label col-xs-2">Password</label>
            <div class="col-xs-10">
                <input type="password" class="form-control" id="inputPassword" placeholder="Password" />
            </div>
        </div>
        
        <div class="form-group">
            <div class="col-xs-offset-2 col-xs-10">
                <div class="checkbox">
                    <label><input type="checkbox" /> Remember me</label>
                </div>
            </div>
        </div>
        
        
    </form -->
    
    
    
    
    
        </div>
    </div>
)
