xquery version "1.0-ml";

import module namespace search = "http://marklogic.com/appservices/search" at "/MarkLogic/appservices/search/search.xqy";

declare variable $term as xs:string := xdmp:get-request-field("term", "");

search:search($term) 
