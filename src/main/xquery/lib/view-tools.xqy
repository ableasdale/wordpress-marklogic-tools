xquery version "1.0-ml";

module namespace view-tools = "http://www.xmlmachines.com/view-tools";

declare function view-tools:create-html-page($head, $content) {
xdmp:set-response-content-type("text/html; charset=utf-8"),
("<!DOCTYPE html>",
<html lang="en">
    {$head}    
    <body role="document">
        {$content},
        {view-tools:javascript-footer()}
    </body>    
</html>
)};

declare function view-tools:javascript-footer(){
    (
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">{" "}</script>,
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js">{" "}</script>
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
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css" />
	{$additional-content}
</head>
)
};

declare function view-tools:get-tiny-mce-js(){
    (<script src="https://tinymce.cachefly.net/4.1/tinymce.min.js">{" "}</script>,
    <script language="javascript" type="text/javascript">
        <![CDATA[tinymce.init({selector:'textarea'});]]>
    </script>)
};

declare function view-tools:create-wp-admin-html-page($title as xs:string, $head, $content) { 
    let $pagebody := (
    <div class="container">
		<div class="sixteen columns">
            <h2>{$title}</h2>
            {view-tools:wp-admin-navigation()}
            {$content}
        </div>      
    </div>
    )
    return view-tools:create-html-page(view-tools:create-wp-admin-html-head($title, $head), $pagebody)
};

declare function view-tools:wp-admin-navigation() as element(div) {
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse"
                        data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">WordPress/MarkLogic Tools</a>
                </div>
                
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <!-- TODO - add class="active" to active page -->
                        <li><a href="/dashboard.xqy">Dashboard</a></li>
                        <li><a href="/posts.xqy">Posts</a></li>
                        <li><a href="#media">Media</a></li>
                        <li><a href="/pages.xqy">Pages</a></li>
                        <li><a href="#comments">Comments</a></li>
                        <li><a href="/users.xqy">Users</a></li>
                        <li><a href="#tools">Tools</a></li>
                        
                        <!-- li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown
                                    <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li class="divider"></li>
                                <li class="dropdown-header">Nav header</li>
                                <li><a href="#">Separated link</a></li>
                                <li><a href="#">One more separated link</a></li>
                            </ul>
                        </li -->
                    </ul>
                </div>
                
            </div>
        </div>



    (: Simplified nav 
    <ul id="wp-admin-nav">
        <li><a href="/dashboard.xqy">Dashboard</a></li>
        <li><a href="/posts.xqy">Posts</a></li>
        <li>Media</li>
        <li><a href="/pages.xqy">Pages</a></li>
        <li>Comments</li>
        <li><a href="/users.xqy">Users</a></li>
        <li>Tools</li>
    </ul> :)
};

declare function view-tools:create-thead-element($headers as xs:string*) as element(thead){
    element thead {
        element tr {
            for $header in $headers
            return element th {$header}
        }
    }
};