xquery version "1.0-ml";

module namespace view-tools = "http://www.xmlmachines.com/view-tools";

declare function view-tools:create-html-page($content) {
xdmp:set-response-content-type("text/html; charset=utf-8"),
("<!DOCTYPE html>",
<html>
<body>
    {$content}
</body>
</html>
)};

declare function view-tools:create-thead-element($headers as xs:string*) as element(thead){
    element thead {
        element tr {
            for $header in $headers
            return element th {$header}
        }
    }
};