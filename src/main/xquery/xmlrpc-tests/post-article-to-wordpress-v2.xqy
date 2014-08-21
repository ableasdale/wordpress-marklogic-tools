xquery version "1.0-ml";

declare default element namespace "http://www.w3.org/1999/xhtml";

declare function local:create-img($document-node as document-node()) as element(div)
{
    element div {
      attribute class {"detail-img"},
      element img {
        attribute src {concat("/", $document-node/*:html/*:body//*:div[@class = "content-detail"]/*:div[@class = "detail-img"]/*:img/@src)},
        attribute alt {"Feature image"}
      }
    }
};

declare function local:content-text($document-node as document-node()) as element(div)
{
    $document-node/*:html/*:body//*:div[@class = "content-detail"]/*:div[@class = "detail-text"]
};

declare function local:get-title($document-node as document-node()) as xs:string
{
    $document-node/*:html/*:body//*:div[@class = "content-detail"]//h1/text()
};

declare function local:excerpt($document-node as document-node()) 
{
    $document-node/*:html/*:body//*:div[@class = "content-detail"]/*:div[@class = "detail-text"]/node()[1]
};

declare function local:build-payload($doc as document-node()) as element(methodCall)
{
 <methodCall>
      <methodName>wp.newPost</methodName>
      <params>
          <param><value>1</value></param>
          <param><value>USER</value></param>
          <param><value>PASSWORD</value></param>
          <struct>
              <member>
                <name>post_content</name>
                <value>{xdmp:quote(<div class="article-content">{(local:create-img($doc), local:content-text($doc))}</div>)}</value>
              </member>
              <member>
                <name>post_title</name>
                <value>{local:get-title($doc)}</value>
              </member>
              <member>
                <name>post_date</name>
                <value><dateTime.iso8601>20110812T08:58:28</dateTime.iso8601></value>
              </member>
              <member>
                <name>post_excerpt</name>
                <value>{xdmp:quote(local:excerpt($doc))}</value>
              </member>
          </struct>  
      </params>
  </methodCall>
};


xdmp:http-post("http://www.yourdomain.com/wp-installdir/xmlrpc.php",
    <options xmlns="xdmp:http">
        <data>{xdmp:quote(local:build-payload(doc()[1]))}</data>
       <headers>
         <content-type>text/xml</content-type>
       </headers>
    </options>) 