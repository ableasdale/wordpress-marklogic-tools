xquery version "1.0-ml";

import module namespace wp-export-data = "http://www.xmlmachines.com/wp-export-data" at "/lib/wp-export-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";
(: import module namespace consts = "http://www.xmlmachines.com/consts" at "/lib/consts.xqy"; :)

view-tools:create-html-page(
    <div id="content">
        <h2>Dashboard</h2>
        <div id="at-a-glance">
            <h3>At a glance widget (from dashboard)</h3>
            <p>{fn:count(wp-export-data:get-posts())} posts</p>
            <p>TODO - how many published/pending etc..</p>     
            <p>{fn:count(wp-export-data:get-pages())} pages</p>
            <p>{fn:count(wp-export-data:get-comments())} comments</p>
        </div>
    </div>)