xquery version "1.0-ml";

declare variable $fname as xs:string := xdmp:get-request-field("fname", ());

(xdmp:set-server-field("filename", $fname),

xdmp:document-get($fname))