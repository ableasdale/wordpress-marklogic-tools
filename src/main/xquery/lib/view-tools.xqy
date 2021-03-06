xquery version "1.0-ml";

module namespace view-tools = "http://www.xmlmachines.com/view-tools";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace consts = "http://www.xmlmachines.com/consts" at "/lib/consts.xqy"; 

declare namespace cts = "http://marklogic.com/cts";
declare namespace xdmp = "http://marklogic.com/xdmp";

declare namespace excerpt = "http://wordpress.org/export/1.2/excerpt/";
declare namespace content = "http://purl.org/rss/1.0/modules/content/"; 
declare namespace wfw = "http://wellformedweb.org/CommentAPI/"; 
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace wp = "http://wordpress.org/export/1.2/";

declare function view-tools:create-html-page( $head as element(head), $content as element(div) ) as item()+ {
xdmp:set-response-content-type("text/html; charset=utf-8"),
("<!DOCTYPE html>",
<html lang="en">
    {$head}    
    <body role="document">
        {$content}
        {view-tools:footer()}
        {view-tools:javascript-footer()}
    </body>    
</html>
)};

declare function view-tools:footer() as element(footer) {
    <footer class="footer">
        <div class="container">
            <p class="text-muted">MLPress: WordPress, MarkLogic style - v0.2 PRE - (MMXIV - MMXVI)</p>
        </div>
    </footer>    
};

declare function view-tools:javascript-footer() as element(script)+ {
    (
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.14.1/moment.min.js">{" "}</script>,
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">{" "}</script>,
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js">{" "}</script>,
    <script><![CDATA[
        $(".date").each(function(){ 
            $(this).html(moment($(this).text(), "ddd, DD MMM YYYY HH:mm:ss ZZ").format("MMM Do YYYY, h:mm a"));
            // dddd, MMMM Do YYYY, h:mm:ss a
            // 'MMMM Do YYYY, h:mm:ss a'
        });        
        // TODO - other date formatting?
    ]]></script>
    )
};

declare function view-tools:create-wp-admin-html-head($title as xs:string, $additional-content as item()*) as element(head) {
(
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico" -->
    <title>{$title}</title>
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" />
    <link rel="stylesheet" href="/wp-admin/css/styles.css" />    
	{$additional-content}
</head>
)
};

declare function view-tools:create-range-frequency-badges($href as xs:string, $type as xs:string) as element(a)* {
    for $i in ml-wp-data:range-query($type)
    return view-tools:create-badge-link( concat($href,"?filter=",$i), concat(cts:frequency($i), " ", $i))
};

declare function view-tools:get-export-directories() as element(dir:directory)* { 
    for $i in $consts:DIRECTORIES return xdmp:filesystem-directory($i)
};

declare function view-tools:get-tiny-mce-js() as element(script)+ {
    (<script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/4.7.4/tinymce.min.js">{" "}</script>,
    <script language="javascript" type="text/javascript">
        <![CDATA[tinymce.init({
            selector : 'textarea', 
            
            plugins: [
                "advlist autolink lists link image charmap print preview hr anchor pagebreak",
                "searchreplace wordcount visualblocks visualchars code fullscreen",
                "insertdatetime media nonbreaking save table contextmenu directionality",
                "template paste textcolor colorpicker textpattern"
            ],
            toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
            
            image_advtab: true,
            
            height : 500 });]]>
    </script>)
    (: toolbar2: "print preview media | forecolor backcolor emoticons", :)
};

declare function view-tools:create-wp-admin-html-page($title as xs:string, $head, $content) as item()* { 
    let $pagebody := (
    <div class="container">
		<div class="row">
            <h3>MLPress <small>{$title}</small></h3>
            {view-tools:wp-admin-navigation()}
        </div>  
        {$content}            
    </div>
    )
    return view-tools:create-html-page(view-tools:create-wp-admin-html-head($title, $head), $pagebody)
};


declare function view-tools:create-input-element($type as xs:string, $class as xs:string, $name as xs:string, $id as xs:string) as element(input) {
    element input {
        attribute type {$type},
        attribute class {$class},
        attribute name {$name},
        attribute id {$id}
    }
};

(: declare function view-tools:create-navbar-links - TODO - this needs to be done when the rewriter is hooked up :)

declare function view-tools:wp-admin-navigation() as element(div) {
    <div class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
            
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                </button>
                <img src="/assets/images/wordpress-logo-32.png"/>          
                <img id="nav-logo" src="/assets/images/marklogic.png"/>                              
            </div>
            
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <!-- TODO - add class="active" to active page -->
                    <li><a href="/wp-admin/dashboard.xqy">Dashboard</a></li>
                    
                    
                    <li class="dropdown">
                        <a href="/wp-admin/posts.xqy" class="dropdown-toggle" data-toggle="dropdown">Posts <span class="caret"></span></a>
                    
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/wp-admin/posts.xqy">All Posts</a></li>
                            <li><a href="/wp-admin/editor.xqy">Add New</a></li>
                            <li><a href="/wp-admin/categories.xqy">Categories</a></li>
                            <li><a href="/wp-admin/tags.xqy">Tags</a></li>
                        </ul>
                    </li>

                    <!-- TODO - paginate media view to save stessing the webserver by requesting *all* images stored in WP -->
                    <li class="dropdown">
                        <a href="/wp-admin/media.xqy" class="dropdown-toggle" data-toggle="dropdown">Media <span class="caret"></span></a>                       
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/wp-admin/media.xqy">Library</a></li>
                            <li><a href="/wp-admin/upload.xqy">Add New</a></li>                                
                        </ul>
                    </li>

                    <!-- TODO - remember to wire up actives when rest rewriter is hooked up <li class="active"><a href="/wp-admin/media.xqy">Media</a></li> -->
                    
                    
                    <li><a href="/wp-admin/pages.xqy">Pages</a></li>
                    <li><a href="/wp-admin/comments.xqy">Comments</a></li>
                    <li><a href="/wp-admin/users.xqy">Users</a></li>
                    <!-- li><a href="#tools">Tools</a></li -->
                    
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tools <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/wp-admin/import.xqy">Import</a></li>
                            <li><a href="/wp-admin/export.xqy">Export to Wordpress</a></li>
                            <!-- li class="divider"></li>
                            <li class="dropdown-header">Nav header</li>
                            <li><a href="#">Separated link</a></li>
                            <li><a href="#">One more separated link</a></li -->
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Settings <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/wp-admin/settings-general.xqy">General</a></li>
                            <!-- li class="divider"></li>
                            <li class="dropdown-header">Nav header</li>
                            <li><a href="#">Separated link</a></li>
                            <li><a href="#">One more separated link</a></li -->
                        </ul>
                    </li>       
                </ul>
                <form action="/wp-admin/search.xqy" method="post" class="navbar-form navbar-left" role="search">
                    <div class="input-group">
                        <input type="text" class="form-control sm" name="term" placeholder="Search" />
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
                        </span>
                        </div>
                </form>
            </div>  
        </div>
    </div>
};

declare private function view-tools:alert-user($level, $message, $is-dismissible) {
if ($is-dismissible)
then (
    element div {
            attribute class {("alert " || $level || " alert-dismissible" )},
            attribute role {"alert"},
            element button {
                attribute class {"close"}, 
                attribute data-dismiss {"alert"}, 
                element span {
                    attribute aria-hidden {"true"}, "&times;"}, 
                    element span {attribute class {"sr-only"}, "Close"}},                
            $message
    }
)
else (
    element div {
        attribute class {("alert " || $level)},
        attribute role {"alert"},
            $message                
    }
)
};

(: 4 classes of visual alert to notify user :)

declare function view-tools:success-notification($message, $is-dismissible as xs:boolean) {
    view-tools:alert-user("alert-success", $message, $is-dismissible)
};

declare function view-tools:info-notification($message, $is-dismissible as xs:boolean) {
    view-tools:alert-user("alert-info", $message, $is-dismissible)
};

declare function view-tools:warning-notification($message, $is-dismissible as xs:boolean) {
    view-tools:alert-user("alert-warning", $message, $is-dismissible)
};

declare function view-tools:danger-notification($message, $is-dismissible as xs:boolean) {
    view-tools:alert-user("alert-danger", $message, $is-dismissible)
};
  
  
declare function view-tools:create-badge-link($href as xs:string, $linktext as xs:string) as element(a) {
    element a { attribute href {$href}, element span {attribute class {"badge"}, $linktext}}
};

declare function view-tools:create-href-link($href as xs:string, $linktext as xs:string) as element(a) {
    element a { attribute href {$href}, $linktext }
};

declare function view-tools:create-tag-badge-link($href as xs:string, $linktext as xs:string) as element(a) {
    element a {attribute href {$href}, element span {attribute class {"badge"}, element span {attribute class {"glyphicon glyphicon-tag"}, " "}," ",$linktext}}
};

declare function view-tools:create-glyphicon-badge-link($href as xs:string, $linktext as xs:string, $glyphicon as xs:string) as element(a) {
    element a {attribute href {$href}, element span {attribute class {"label label-primary mgn-right"}, element span {attribute class {$glyphicon}, " "}," ",$linktext}}
};

declare function view-tools:build-document-state-dropdown($state as xs:string) {
    <select class="form-control" name="status">
        {
            for $x in ("draft", "pending", "publish")
            return element option {attribute value {$x},
                if ($state eq $x)
                then (attribute selected {"selected"})
                else(),
                concat(upper-case(substring($x,1,1)), substring($x,2))}
        }
    </select>
};

declare function view-tools:create-thead-element($headers as xs:string*) as element(thead) {
    element thead {
        element tr {
            for $header in $headers
            return element th {attribute class {"text-center"}, $header}
        }
    }
};


(: "Widget" code below :)

declare function view-tools:summary-widget($title as xs:string) as element(div) {
    <div class="panel panel-default">
        <div class="panel-heading">
        <h3 class="panel-title">{$title}</h3>
        </div>
        <div class="panel-body">
        {
            element h4 {view-tools:create-glyphicon-badge-link("/wp-admin/posts.xqy", concat(ml-wp-data:get-total-posts(), ""), "glyphicon glyphicon-pushpin mgn-right"), " Posts"},
            element p {attribute class {"counts"},view-tools:create-range-frequency-badges("/wp-admin/posts.xqy", "post")},
            element h4 {view-tools:create-glyphicon-badge-link("/wp-admin/pages.xqy", concat(ml-wp-data:get-total-pages(), ""), "glyphicon glyphicon-book mgn-right"), " Pages"},
            element p {attribute class {"counts"},view-tools:create-range-frequency-badges("/wp-admin/pages.xqy", "pages")},
            element h4 {view-tools:create-glyphicon-badge-link("/wp-admin/comments.xqy", concat(count(ml-wp-data:get-comments()), ""), "glyphicon glyphicon-comment mgn-right"), " Comments"}
            (: TODO - for comments we will need some custom code element p {view-tools:create-range-frequency-badges("/wp-admin/comments.xqy", "comments")} :)
        }
        </div>
    </div>
};

declare function view-tools:recently-published-widget($num as xs:integer) {
    element ul {attribute class {"list-unstyled"},
        for $i in subsequence(ml-wp-data:range-query-recent-posts(), 1, $num)
        return element li {
                element span {attribute class {"text-muted pad-right date"}, $i/item/pubDate}, 
                view-tools:create-href-link(fn:concat("/wp-admin/editor.xqy?id=", xs:string($i/item/wp:post_id)), xs:string($i/item/title))}
    }
};

declare function view-tools:recent-comments($num as xs:integer) {
    element p {"TODO"}
};
