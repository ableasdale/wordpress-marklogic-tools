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


view-tools:create-wp-admin-html-page("Categories", (),
    <div id="categories">
        <h1>TODO - put in a form to add cats</h1>
    
        <table class="table table-striped table-bordered">
            {view-tools:create-thead-element(("Name", "Description", "Slug", "Count"))}
            <tbody>
                {
                    for $x in ml-wp-data:get-categories()
                    return element tr {
                        element td {string($x//wp:cat_name)},
                        element td {string($x//wp:category_description)},
                        element td {string($x//wp:category_nicename)},
                        element td {"TODO"}
                          
                    }   
                }
            </tbody>            
        </table>
    </div>
)