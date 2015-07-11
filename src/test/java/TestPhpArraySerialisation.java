import de.ailis.pherialize.Mixed;
import de.ailis.pherialize.MixedArray;
import de.ailis.pherialize.Pherialize;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created with IntelliJ IDEA.
 * User: alexb
 * Date: 11/07/15
 * Time: 12:29
 * To change this template use File | Settings | File Templates.
 */
public class TestPhpArraySerialisation {

    public static void main(String[] args) {
      Logger LOG = LoggerFactory.getLogger(TestPhpArraySerialisation.class.getCanonicalName());


        /*
        a:5:{s:5:"width";i:665;s:6:"height";i:210;s:4:"file";s:42:"2015/06/Screenshot-2015-04-27-16.40.11.png";s:5:"sizes";a:3:{s:9:"thumbnail";a:4:{s:4:"file";s:42:"Screenshot-2015-04-27-16.40.11-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}s:6:"medium";a:4:{s:4:"file";s:41:"Screenshot-2015-04-27-16.40.11-300x95.png";s:5:"width";i:300;s:6:"height";i:95;s:9:"mime-type";s:9:"image/png";}s:14:"post-thumbnail";a:4:{s:4:"file";s:42:"Screenshot-2015-04-27-16.40.11-665x198.png";s:5:"width";i:665;s:6:"height";i:198;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:11:{s:8:"aperture";i:0;s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";i:0;s:9:"copyright";s:0:"";s:12:"focal_length";i:0;s:3:"iso";i:0;s:13:"shutter_speed";i:0;s:5:"title";s:0:"";s:11:"orientation";i:0;}}
         */

        String data = "a:5:{s:5:\"width\";i:665;s:6:\"height\";i:210;s:4:\"file\";s:42:\"2015/06/Screenshot-2015-04-27-16.40.11.png\";s:5:\"sizes\";a:3:{s:9:\"thumbnail\";a:4:{s:4:\"file\";s:42:\"Screenshot-2015-04-27-16.40.11-150x150.png\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:9:\"image/png\";}s:6:\"medium\";a:4:{s:4:\"file\";s:41:\"Screenshot-2015-04-27-16.40.11-300x95.png\";s:5:\"width\";i:300;s:6:\"height\";i:95;s:9:\"mime-type\";s:9:\"image/png\";}s:14:\"post-thumbnail\";a:4:{s:4:\"file\";s:42:\"Screenshot-2015-04-27-16.40.11-665x198.png\";s:5:\"width\";i:665;s:6:\"height\";i:198;s:9:\"mime-type\";s:9:\"image/png\";}}s:10:\"image_meta\";a:11:{s:8:\"aperture\";i:0;s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";i:0;s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";i:0;s:3:\"iso\";i:0;s:13:\"shutter_speed\";i:0;s:5:\"title\";s:0:\"\";s:11:\"orientation\";i:0;}}";

        MixedArray list;


        list = Pherialize.unserialize(data).toArray();

       LOG.info("*** Top Level Array ***");
        for (Object o : list.keySet()) {
            //Mixed m = list.get(o);
            LOG.info("Key "+ o.toString()+ " Value "+list.get(o));
        }

        LOG.info("*** Sizes ***");
        MixedArray sizes = list.getArray("sizes");
        for (Object o : sizes.keySet()){
            LOG.info("Key "+ o.toString()+ " Value "+sizes.get(o));
        }

    }

}
