
xdmp:http-post("http://www.example.com/wp-install/xmlrpc.php",
        <options xmlns="xdmp:http">
            <data>
            {xdmp:quote(<methodCall>
  <methodName>wp.getMediaItem</methodName>
  <params>
   <param><value>1</value></param>
   <param><value>USER</value></param>
   <param><value>PASSWORD</value></param>
   <param><value>136</value></param>
  </params>
</methodCall>)}</data>
           <headers>
             <content-type>text/xml</content-type>
           </headers>
        </options>
        
        )
