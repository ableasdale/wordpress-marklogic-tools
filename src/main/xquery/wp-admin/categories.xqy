xquery version "1.0-ml";


declare namespace wp = "http://wordpress.org/export/1.2/";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";


(:

<wp:category>
<wp:term_id>6</wp:term_id>
<wp:category_nicename>test-cat</wp:category_nicename>
<wp:category_parent/>
<wp:cat_name>TestCategory</wp:cat_name>
<wp:category_description>TestCategory</wp:category_description>
</wp:category>

<wp:category>
<wp:term_id>7</wp:term_id>
<wp:category_nicename>t-c-c</wp:category_nicename>
<wp:category_parent>test-cat</wp:category_parent>
<wp:cat_name>TestChildCategory</wp:cat_name>
<wp:category_description>here here</wp:category_description>
</wp:category>

:)

declare function local:category-form() {
    <form role="form" class="form-horizontal" action="/wp-admin/update.xqy" method="post">
        <div class="well">
    
             <div class="form-group">
                <label for="cat-name" class="control-label col-sm-3">Name</label>
                <div class="col-sm-9">
                    <div class="input-group">
                        {
                        element input {
                                attribute type {"text"},
                                attribute class {"form-control"},
                                attribute name {"title"}, (: Note this is renamed so the req. field can be used for either cat or article :)
                                attribute id {"cat-name"}
                            }             
                        }
                        <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk req">{" "}</span></span>
                    </div>
                </div>
            </div>
            
            
            
    
            <div class="form-group">
                <label for="tagline" class="control-label col-sm-3">Slug</label>
                <div class="col-sm-9">
                    {
                    element input {
                            attribute type {"text"},
                            attribute class {"form-control"},
                            attribute name {"tagline"},
                            attribute id {"tagline"}
                        }             
                    }
                    <span class="help-block">The “slug” is the URL-friendly version of the name. It is usually all lowercase and contains only letters, numbers, and hyphens.  <strong>This will be generated for you.</strong></span>
                </div>
            </div>
            
            <div class="form-group">
                <label for="wp-address-url" class="control-label col-sm-3">Parent</label>
                <div class="col-sm-9">
                    {
                    element input {
                            attribute type {"text"},
                            attribute class {"form-control"},
                            attribute name {"wp-address-url"},
                            attribute placeholder {"TODO"},
                            attribute id {"wp-address-url"}
                        }             
                    }
                </div>
            </div>
            
            <div class="form-group">
                <label for="description" class="control-label col-sm-3">Description</label>
                <div class="col-sm-9">
                    
                    {
                    element input {
                            attribute type {"text"},
                            attribute class {"form-control"},
                            attribute name {"article"}, (: Note this is renamed so the req. field can be used for either cat or article :)
                            attribute id {"description"}
                        }             
                    }
                </div>
            </div>
            
            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-9">
                    <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save mr1e">{" "}</span>Create Category</button>
                </div>
            </div>
            
            <input type="hidden" name="id" value="0" />
            <input type="hidden" name="type" value="category" />
        </div>
    </form>
};

view-tools:create-wp-admin-html-page("Categories", (),
    <div id="categories" class="row">
        <h3>Create Category</h3>
        {local:category-form()}
        <h3>Categories</h3>
        <table class="table table-striped table-bordered">
            {view-tools:create-thead-element(("ID","Name", "Description", "Parent(TODO-Nest)", "Slug", "Count"))}
            <tbody>
                {
                    for $x in ml-wp-data:get-categories()
                    order by number(string($x//wp:term_id)) descending
                    return element tr {
                        element td {string($x//wp:term_id)},
                        element td {string($x//wp:cat_name)},
                        element td {string($x//wp:category_description)},
                        element td {string($x//wp:category_parent)},
                        element td {string($x//wp:category_nicename)},
                        element td {"TODO"}
                          
                    }   
                }
            </tbody>            
        </table>
    </div>
)