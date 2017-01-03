package cl.json.social;

import android.content.ActivityNotFoundException;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReadableMap;

/**
 * Created by disenodosbbcl on 23-07-16.
 */
public class FacebookShare extends SingleShareIntent {

    private static final String PACKAGE = "com.facebook.katana";
    private static final String DEFAULT_WEB_LINK = "https://www.facebook.com/dialog/feed?app_id=1564623213834071&link={url}&picture={image}&description={description}&redirect_uri={base}";

    public FacebookShare(ReactApplicationContext reactContext) {
        super(reactContext);

    }
    @Override
    public void open(ReadableMap options) throws ActivityNotFoundException {
        super.open(options);
        //  MORE DATA
        this.openIntentChooser();
    }
    @Override
    protected String getPackage() {
        return PACKAGE;
    }

    @Override
    protected String getDefaultWebLink() {
        return DEFAULT_WEB_LINK;
    }

    @Override
    protected String getPlayStoreLink() {
        return null;
    }
}
