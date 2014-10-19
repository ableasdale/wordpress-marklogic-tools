xquery version "1.0-ml";

(:
/**
 * Main template file
 *
 * This is the most generic template file in a WordPress theme
 * and one of the two required files for a theme (the other being style.css).
 * It is used to display a page when nothing more specific matches a query.
 * E.g., it puts together the home page when no home.php file exists.
 * Learn more: http://codex.wordpress.org/Template_Hierarchy
 *
 * @package WordPress
 * @subpackage Twenty_Ten
 * @since Twenty Ten 1.0
 */
:)

import module namespace tmpl = "http://www.xmlmachines.com/tmpl" at "tmpl.xqy";

tmpl:get-theme-html-wrapper(
(tmpl:get-header(), 
            <div id="container">
                        <div id="content" role="main">
                                <p>this is index.xqy</p>
                        {(:
                        *
                         * Run the loop to output the posts.
                         * If you want to overload this in a child theme then include a file
                         * called loop-index.php and that will be used instead.
                         * 
			:)
                         tmpl:get-template-part( 'loop', 'index' )
                        }
                        </div>
                </div>,


tmpl:get-sidebar(),
tmpl:get-footer()
)
)