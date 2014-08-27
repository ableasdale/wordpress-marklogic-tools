xquery version "1.0-ml";

declare namespace wp = "http://wordpress.org/export/1.2/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";

import module namespace ml-wp-data = "http://www.xmlmachines.com/ml-wp-data" at "/lib/ml-wp-data.xqy";
import module namespace view-tools = "http://www.xmlmachines.com/view-tools" at "/lib/view-tools.xqy";
import module namespace consts = "http://www.xmlmachines.com/consts" at "/lib/consts.xqy";

declare variable $doc := doc($consts:CONFIG-DOC-URI);

view-tools:create-wp-admin-html-page("General Settings", (),
    <div id="settings">
        <h2>General Settings</h2>
        
        <form role="form" class="form-horizontal" action="/wp-admin/update.xqy" method="post">
            <div class="well">
      
                 <div class="form-group">
                    <label for="site-title" class="control-label col-xs-3">Site Title</label>
                    <div class="col-xs-9">
                        {
                        element input {
                                attribute type {"text"},
                                attribute class {"form-control"},
                                attribute name {"title"},
                                attribute id {"site-title"},
                                attribute value {$doc//title}
                            }             
                        }
                    </div>
                </div>
                
    
                <div class="form-group">
                    <label for="tagline" class="control-label col-xs-3">Tagline</label>
                    <div class="col-xs-9">
                        {
                        element input {
                                attribute type {"text"},
                                attribute class {"form-control"},
                                attribute name {"tagline"},
                                attribute id {"tagline"},
                                attribute value {$doc//description}
                            }             
                        }
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="wp-address-url" class="control-label col-xs-3">WordPress Address (URL)</label>
                    <div class="col-xs-9">
                        {
                        element input {
                                attribute type {"text"},
                                attribute class {"form-control"},
                                attribute name {"wp-address-url"},
                                attribute id {"wp-address-url"},
                                attribute value {$doc//wp:base_blog_url}
                            }             
                        }
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="wp-site-url" class="control-label col-xs-3">Site Address (URL)</label>
                    <div class="col-xs-9">
                        {
                        element input {
                                attribute type {"text"},
                                attribute class {"form-control"},
                                attribute name {"wp-site-url"},
                                attribute id {"wp-site-url"},
                                attribute value {$doc//wp:base_site_url}
                            }             
                        }
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email-address" class="control-label col-xs-3">E-mail Address</label>
                    <div class="col-xs-9">
                        {
                        element input {
                                attribute type {"text"},
                                attribute class {"form-control"},
                                attribute name {"email-address"},
                                attribute id {"email-address"},
                                attribute value {"TODO - where do we get this value from??"}
                            }             
                        }
                    </div>
                </div>
                
                
                <div class="form-group">
                    <div class="col-xs-offset-3 left">
                        <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-hdd"></span> Update</button>
                    </div>
                </div>
                
            </div>
        </form>
    </div>)
    