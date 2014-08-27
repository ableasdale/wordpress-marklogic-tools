xquery version "1.0-ml";

module namespace tmpl = "http://www.xmlmachines.com/tmpl";

declare function tmpl:get-theme-html-wrapper($content) {

xdmp:set-response-content-type("text/html; charset=utf-8"),
("<!DOCTYPE html>",
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>[TODO] Test | Just another WordPress site</title>
<link rel="stylesheet" type="text/css" media="all" href="http://localhost/wp-content/themes/twentyten/style.css" />
</head>
<body class="home blog">
<div id="wrapper" class="hfeed">
{$content}
</div>
</body>
</html>)
};

declare function tmpl:get-header() {
let $config := doc("/app-configuration.xml")
return
(
<div id="header">
    <div id="masthead">
    	
    	<div id="branding" role="banner">
    		<h1 id="site-title">
           		<span>
           			<a href="http://localhost/" title="Test" rel="home">Test</a>
           		</span>
			</h1>
			<div id="site-description">{$config//description}</div>
			<img src="http://localhost/wp-content/themes/twentyten/images/headers/path.jpg" width="940" height="198" alt="" />
		</div>

		<div id="access" role="navigation">
      		<div class="skip-link screen-reader-text"><a href="#content" title="Skip to content">Skip to content</a></div>
			<div class="menu"><ul><li class="current_page_item"><a href="http://localhost/">TODO - Home</a></li><li class="page_item page-item-2"><a href="http://localhost/?page_id=2">Sample Page</a></li></ul></div>
        </div>
        
    </div>
</div>
)};

declare function tmpl:get-template-part( $a, $b) {
(: 'index', 'loop' :)
    <p>{$a, $b}</p>
};

declare function tmpl:get-sidebar() {
    <p>sidebar</p>
};

declare function tmpl:get-footer() {
    (<p>footer</p>)
};