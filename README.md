#MLPress: WordPress, MarkLogic style#

Imagine what it would be like to have a powerful blog application like WordPress built on a modern, highly scalable NoSQL document database like MarkLogic... 

MLPress aims to be a WordPress compatible implementation of WordPress built on top of MarkLogic.  

MLPress allows you to import your exported WordPress XML, to make edits and to re-export that XML and import it back into WordPress if required.

Features include:
- 100% MarkLogic Goodness :)
- Support for XQuery and JavaScript for ultimate developer flexibility
- Search your posts, media and pages with MarkLogic
- Allows the import of very large WordPress XML export files  

## How Complete is it? ##
Basic import, edit and export work but the project is still under heavy development.  Watch this space!

## Can I make feature requests? ##
Absolutely! Please email me at alex.bleasdale@marklogic.com and/or feel free to create an issue in GitHub

## Prerequisites ##
Requires MarkLogic 8 and a database (currently configured to use Documents) with the collection lexicon enabled

### Setup ###

Set the values below for your database, default application port and configure the module path to the project (replacing /ROOT/PATH/TO with the location on your filesystem where this project is checked out). 

```xquery
xquery version "1.0-ml";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";

declare variable $DATABASE as xs:string := "Documents";
declare variable $PORT as xs:unsignedLong := 8003;
declare variable $PATH := "/ROOT/PATH/TO/wordpress-marklogic-tools/src/main/xquery";

declare function local:create-http-application-server() {
  let $config := admin:get-configuration()
  let $config := admin:http-server-create($config, admin:group-get-id($config, "Default"), fn:concat("http-",$PORT),
        $PATH, $PORT, 0, xdmp:database($DATABASE))
(:  let $config := admin:appserver-set-authentication($config,
         admin:appserver-get-id($config, admin:group-get-id($config, "Default"), fn:concat("http-",$PORT)),
         "application-level") :)
  return
  admin:save-configuration($config)
};

local:create-http-application-server()
```

### Configure ###

Modify: **\wordpress-marklogic-tools\src\main\xquery\lib\consts.xqy** to set the import directory

```xquery
declare variable $DIRECTORIES as xs:string+ := ("/ROOT/PATH/TO/wordpress-marklogic-tools/sample-exports");
```