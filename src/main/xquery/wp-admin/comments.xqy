xquery version "1.0-ml";

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

view-tools:create-wp-admin-html-page("Comments", (),
    <div id="comments" class="row">
        <table class="table table-striped table-bordered">
            {view-tools:create-thead-element(("Author", "Comment", "In Response To"))}
            <tbody>
                {
                    for $x in ml-wp-data:get-comments()
                    return element tr {
                        element td { string($x//wp:comment_author),  string($x//wp:comment_author_url) },
                        element td { "Submitted on ", string($x//wp:comment_date), "TODO - this links back to a post on the blog page ", string($x//wp:comment_content) },
                        element td { string(fn:root($x)//title) }
                    }
                }
            </tbody>            
        </table>
    </div>)

(: TODO - editorial features are missing

Mr WordPress
https://wordpress.org/
Submitted on 2014/08/24 at 5:49 am
Hi, this is a comment.
To delete a comment, just log in and view the post's comments. There you will have the option to edit or delete them.

Unapprove | Reply | Quick Edit | Edit | Spam | Trash

:)