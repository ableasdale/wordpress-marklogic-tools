xquery version "1.0-ml";

xdmp:http-post("http://www.domain.com/wp-installpath/xmlrpc.php",
        <options xmlns="xdmp:http">
            <data>
            {xdmp:quote(<methodCall>
  <methodName>wp.getPost</methodName>
  <params>
   <param><value>1</value></param>
   <param><value>USER</value></param>
   <param><value>PASSWORD</value></param>
   <param><value>226</value></param>
  </params>
</methodCall>)}</data>
           <headers>
             <content-type>text/xml</content-type>
           </headers>
        </options>
        
        ) 
