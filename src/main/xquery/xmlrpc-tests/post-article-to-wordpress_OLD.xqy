xquery version "1.0-ml";

declare default element namespace "http://www.w3.org/1999/xhtml";


xdmp:http-post("http://www.sampledomain.com/wp-install/xmlrpc.php",
    <options xmlns="xdmp:http">
        <data>{xdmp:quote(
            <methodCall>
                <methodName>wp.newPost</methodName>
                <params>
                    <param><value>1</value></param>
                    <param><value>wp-username</value></param>
                    <param><value>password</value></param>
                    <struct>
                        <member>
                          <name>post_content</name>
                          <value>{doc("/test")/*:html/*:body//*:div[@class = "content-detail"]}</value>
                        </member>
                        <member>
                          <name>post_title</name>
                          <value>Automated post test</value>
                        </member>
                        <member>
                          <name>post_date</name>
                          <value><dateTime.iso8601>20100812T08:58:28</dateTime.iso8601></value>
                        </member>
                        <member>
                          <name>post_excerpt</name>
                          <value>Excerpt here</value>
                        </member>
                    </struct>  
                </params>
            </methodCall>
        )}</data>
       <headers>
         <content-type>text/xml</content-type>
       </headers>
    </options>)
     