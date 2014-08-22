xquery version "1.0-ml";

module namespace view-tools = "http://www.xmlmachines.com/view-tools";

declare function view-tools:create-html-page($head, $content) {
xdmp:set-response-content-type("text/html; charset=utf-8"),
("<!DOCTYPE html>",
<html>
    <head>
        {$head}
    </head>    
    <body>
        {$content}
    </body>
</html>
)};

declare function view-tools:create-wp-admin-html-head() {
(
    <link rel="stylesheet" href="css/base.css" />,
	<link rel="stylesheet" href="css/skeleton.css" />,
	<link rel="stylesheet" href="css/layout.css" />
)
};

declare function view-tools:create-wp-admin-html-page($title as xs:string, $content) { 
    let $pagebody := (
    <div class="container">
		<div class="sixteen columns">
            <h2>{$title}</h2>
            {view-tools:wp-admin-navigation()}
            {$content}
        </div>      
    </div>
    )
    return view-tools:create-html-page(view-tools:create-wp-admin-html-head(), $pagebody)
};

declare function view-tools:wp-admin-navigation() as element(ul) {
    (: Simplified nav :)
    <ul id="wp-admin-nav">
        <li><a href="/dashboard.xqy">Dashboard</a></li>
        <li><a href="/posts.xqy">Posts</a></li>
        <li>Media</li>
        <li><a href="/pages.xqy">Pages</a></li>
        <li>Comments</li>
        <li><a href="/users.xqy">Users</a></li>
        <li>Tools</li>
    </ul>
};

declare function view-tools:create-thead-element($headers as xs:string*) as element(thead){
    element thead {
        element tr {
            for $header in $headers
            return element th {$header}
        }
    }
};