xquery version "1.0-ml";

module namespace view-tools = "http://www.xmlmachines.com/view-tools";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace consts = "http://www.xmlmachines.com/consts" at "/lib/consts.xqy"; 

declare function view-tools:create-html-page($head, $content) {
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
            <p class="text-muted">MarkLogic WordPress Tools - v0.1 PRE - (MMXIV - MMXV)</p>
        </div>
    </footer>    
};

declare function view-tools:javascript-footer(){
    (
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">{" "}</script>,
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js">{" "}</script>
    )
};

declare function view-tools:create-wp-admin-html-head($title as xs:string, $additional-content) {
(
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico" -->
    <title>{$title}</title>
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css" />
    <link rel="stylesheet" href="/wp-admin/css/styles.css" />
    <style type="text/css"><![CDATA[
    /* Sticky footer styles */
        html {
            position: relative;
            min-height: 100%;
        }
        
        .footer {
            position: absolute;
            bottom: 0;            
            width: 100%;
            height:2em;
        }
        
        .footer .container {
            text-align:center;            
            padding-top:2em;   
        }
        
        /* Thumbnail 
        .small-thumbnail {width:100px; height:100px;}
        */
        .small-thumbnail {
  position: relative;
  width: 100px;
  height: 100px;
  overflow: hidden;
}
.small-thumbnail img {
  position: absolute;
  left: 50%;
  top: 50%;
  height: 100%;
  width: auto;
  -webkit-transform: translate(-50%,-50%);
      -ms-transform: translate(-50%,-50%);
          transform: translate(-50%,-50%);
}
.small-thumbnail img.portrait {
  width: 100%;
  height: auto;
}
        ]]>
    </style>    
	{$additional-content}
</head>
)
};

declare function view-tools:summary-widget($title as xs:string) {
<div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">{$title}</h3>
    </div>
    <div class="panel-body">
        <p><a href="/wp-admin/posts.xqy"><span class="badge mr1e">{fn:count(ml-wp-data:get-posts())}</span>Posts</a></p>
        <p>TODO - how many published/pending etc..</p>     
        <p><a href="/wp-admin/pages.xqy"><span class="badge mr1e">{fn:count(ml-wp-data:get-pages())}</span>Pages</a></p>
        <p><a href="/wp-admin/comments.xqy"><span class="badge mr1e">{fn:count(ml-wp-data:get-comments())}</span>Comments</a></p>
    </div>
</div>
};

declare function view-tools:get-export-directories() { 
    for $i in $consts:DIRECTORIES return xdmp:filesystem-directory($i)
};

declare function view-tools:get-tiny-mce-js(){
    (<script src="https://tinymce.cachefly.net/4.1/tinymce.min.js">{" "}</script>,
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

declare function view-tools:create-wp-admin-html-page($title as xs:string, $head, $content) { 
    let $pagebody := (
    <div class="container">
		<div class="row">
            <h2>MarkPress <small>{$title}</small></h2>
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
                    <img style="margin: 0.65em 0.4em 0 0.7em;" src="/assets/images/marklogic.png"/>
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
                    <form class="navbar-form navbar-left" role="search">
                        <div class="input-group">
                            <input type="text" class="form-control sm" placeholder="Search" />
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

(:
<span class="glyphicon glyphicon-tag"></span>
:)

declare function view-tools:create-thead-element($headers as xs:string*) as element(thead) {
    element thead {
        element tr {
            for $header in $headers
            return element th {attribute class {"text-center"}, $header}
        }
    }
};

