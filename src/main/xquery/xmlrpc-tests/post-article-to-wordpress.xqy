xquery version "1.0-ml";
(:
let $item := xdmp:document-get("http://www.domain.com/artcle.php?id=16", 
<options xmlns="xdmp:document-get" xmlns:http="xdmp:http">
           <format>xml</format>
           <repair>full</repair>        
       </options>)
return xdmp:document-insert("/test", $item) :)

declare default element namespace "http://www.w3.org/1999/xhtml";
(:        
doc("/test")/*:html/*:body//*:div[@class = "content-detail"]
:)

(:  :)

xdmp:http-post("http://www.sampledomain.com/path-to/xmlrpc.php",
     <options xmlns="xdmp:http">
     
       <data>
       {xdmp:quote(
       <methodCall>
  <methodName>wp.newPost</methodName>
  <params>
   <param><value>1</value></param>
   <param><value>wp-admin</value></param>
   <param><value>password-here</value></param>
   
    <struct>
      <member>
        <name>post_content</name>
        <value>Example content for article</value>
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

)}
</data>
       <headers>
         <content-type>text/xml</content-type>
       </headers>
     </options>)
     
     
     
     (: {xdmp:quote(<p>test</p>)} :)
     
     (:        TODO - BELOW are examples - at some stage turn these into a fully fledged module that can do this elegantly and (type) safely
       <methodCall>
  <methodName>wp.newPost</methodName>
  <params>
   <param><value>1</value></param>
   <param><value>uname</value></param>
   <param><value>paswordwouldgohere</value></param>
   <param><value>72</value></param>
  </params>
</methodCall> :)
(:   <methodCall>
  <methodName>wp.getPost</methodName>
  <params>
   <param><value>1</value></param>
   <param><value>uname</value></param>
   <param><value>paswordwouldgohere</value></param>
   <param><value>1</value></param>
  </params>
</methodCall> :)

(: Structure note from interrogating XMLRPC endpoint

<member>
        <name>wp_slug</name>
        <value><string></string></value>
      </member>
      <member>
        <name>wp_password</name>
        <value><string></string></value>
      </member>
      <member>
        <name>wp_page_parent_id</name>
        <value><int></int></value>
      </member>
      <member>
        <name>wp_page_order</name>
        <value><int></int></value>
      </member>
      <member>
        <name>wp_author_id</name>
        <value><int>1</int></value>
      </member>    
      <member>
        <name>title</name>
        <value>This is the title</value>
      </member>
      <member>
        <name>description</name>
        <value><string>description</string></value>
      </member>
      <member>
        <name>mt_excerpt</name>
        <value><string></string></value>
      </member>
      <member>
        <name>mt_text_more</name>
        <value><string></string></value>
      </member>    
      <member>
        <name>mt_allow_comments</name>
        <value><int>1</int></value>
      </member>  
      <member>
        <name>mt_allow_pings</name>
        <value><int>1</int></value>
      </member>
      <member>
        <name>mt_allow_pings</name>
        <value><datetime></datetime></value>
      </member>
      
      :)
