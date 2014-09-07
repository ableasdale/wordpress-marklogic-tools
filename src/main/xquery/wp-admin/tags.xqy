xquery version "1.0-ml";

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

declare function local:tag-form() {
<form role="form" class="form-horizontal" action="/wp-admin/update.xqy" method="post">
    <div class="well">

         <div class="form-group">
            <label for="tag-name" class="control-label col-sm-3">Name</label>
            <div class="col-sm-9">
                <div class="input-group">
                    {view-tools:create-input-element("text", "form-control", "title", "tag-name") }
                    <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk req">{" "}</span></span>
                </div>
            </div>
        </div>
        
        <div class="form-group">
            <label for="tag-slug" class="control-label col-sm-3">Slug</label>
            <div class="col-sm-9">
                {view-tools:create-input-element("text", "form-control", "tag-slug", "tag-slug") }
                <span class="help-block">The “slug” is the URL-friendly version of the name. It is usually all lowercase and contains only letters, numbers, and hyphens.  <strong>This will be generated for you.</strong></span>
            </div>
        </div>
        
        <div class="form-group">
            <label for="description" class="control-label col-sm-3">Description</label>
            <div class="col-sm-9">
                <!-- Note this is renamed (as "article") so the req. field can be used for either cat or article -->
                {view-tools:create-input-element("text", "form-control", "article", "description") }  
            </div>
        </div>
        
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9">
                <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save mr1e">{" "}</span>Create Tag</button>
            </div>
        </div>
        
        <input type="hidden" name="id" value="0" />
        <input type="hidden" name="type" value="tag" />
    </div>
</form>
};


view-tools:create-wp-admin-html-page("Tags", (),
    <div id="tags">
        <h3>Create Tag</h3>
        {local:tag-form()}
        <h3>Tags</h3>
        <table class="table table-striped table-bordered">
            {view-tools:create-thead-element(("ID", "Name", "Description", "Slug", "Count"))}
            <tbody>
                {
                    for $x in ml-wp-data:get-tags()
                    return element tr {
                        element td { string($x//wp:term_id) },
                        element td { string($x//wp:tag_name) },
                        element td { string($x//wp:tag_description) },
                        element td { string($x//wp:tag_slug)},
                        element td { "TODO" }
                    }
                }
            </tbody>            
        </table>
    </div>)
    
(:

<wp:tag><wp:term_id>9</wp:term_id><wp:tag_slug>test</wp:tag_slug><wp:tag_name>test</wp:tag_name><wp:tag_description>do people really describe tags?</wp:tag_description></wp:tag>
:)