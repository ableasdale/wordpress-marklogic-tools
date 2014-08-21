xquery version "1.0-ml";

(: Some notes on cleaning up skanky markup from raw MySQL dump :)

(: PULL Images to local disk
for $x in 451 to 500
let $item := xdmp:document-get(concat("http://www.domain.com/path/to/images/",$x,".jpg"))
return (xdmp:save(concat("F:\assets\",$x,".jpg"), $item), $item)
:)

(: PULL DATA FROM MySQL XML Dump (taken from a legacy non WP database - but using the phpmyadmin XML export 
declare variable $data := xdmp:document-get("e:\news.xml");

for $i at $pos in $data//table
return xdmp:document-insert(concat("/news-item", $pos), $i) :)

(: doc()//column[@name = "news_id"] 
declare variable $data := xdmp:document-get("e:\issue-cat.xml");
for $i at $pos in $data//table
return xdmp:document-insert(concat("/issue-cat", $pos), $i) :)
(: element div { :)


declare variable $clean := element data { 
    xdmp:tidy(fn:replace(doc()[1]//column[@name = "news_detail"],"\\",""),   
    
    <options xmlns="xdmp:tidy">
        <word-2000>yes</word-2000>
        <bare>yes</bare>
        <clean>yes</clean>
        <force-output>yes</force-output>
        <quiet>yes</quiet>
        <show-body-only>yes</show-body-only>
        <show-warnings>no</show-warnings>
        <hide-comments>yes</hide-comments>
    </options>)};

declare function local:contains-alphabet-chars($arg as xs:string?)  as xs:boolean 
{
    some $searchString in ("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z") 
    satisfies contains($arg,$searchString)
};


for $i in $clean//text()
where local:contains-alphabet-chars($i)
return <p>{fn:normalize-space($i)}</p>
 