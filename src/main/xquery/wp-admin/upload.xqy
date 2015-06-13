xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

view-tools:create-wp-admin-html-page("Upload Media", 
(
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/4.0.1/min/dropzone.min.js">{" "}</script>,
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/4.0.1/min/dropzone.min.css" />
),
    <div id="upload" class="row">
        <div class="panel panel-default">
            <div class="panel-heading"><strong>Upload Files</strong>&nbsp;<small>TODO</small></div>
            <div class="panel-body">
                <form enctype="multipart/form-data" action="/upload" method="post" class="dropzone" id="dropzone" style="border: 0.5em dashed; color: #999; text-transform:uppercase;">{" "}</form>
            </div>
        </div>
    </div>
)