xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";

import module namespace wp-export-data = "http://www.xmlmachines.com/wp-export-data" at "/lib/wp-export-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";

xdmp:set-response-content-type("text/html; charset=utf-8"),
("<!DOCTYPE html>",
<html>
<head>
    <script src="https://tinymce.cachefly.net/4.1/tinymce.min.js">{" "}</script>
    

    <script language="javascript" type="text/javascript">
    <![CDATA[
        
        tinymce.init({selector:'textarea'});
/*        
tinymce.init({
    selector : "textarea",
    elements : "editor",
    plugins: [
        "advlist autolink lists link image charmap print preview anchor",
        "searchreplace visualblocks code fullscreen",
        "insertdatetime media table contextmenu paste moxiemanager"
    ],
    toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image"
}); */
]]>
</script>
</head>

<body>
    <textarea>Your content here.</textarea>
    
    <!-- div id="content">
        <div id="mce">
            <form method="post" action="somepage">
                <textarea name="editor" id="editor" style="width:100%">test</textarea>
            </form>
        </div> 
    </div -->
</body>
</html>
)






