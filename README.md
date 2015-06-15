## Prerequisites ##
Requires MarkLogic 8 and a database (currently configured to use Documents) with the collection lexicon enabled

### Setup ###
```
xquery version "1.0-ml";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";

declare variable $DATABASE as xs:string := "Documents";
declare variable $PORT as xs:unsignedLong := 8003;
declare variable $PATH := "D:\workspace\wordpress-marklogic-tools\src\main\xquery";

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

```
declare variable $DIRECTORIES as xs:string+ := ("/ROOT/PATH/TO/wordpress-marklogic-tools/sample-exports");
```