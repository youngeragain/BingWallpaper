package xcj.app.flutter.bing_wallpaper

import android.app.Application
import android.util.Log

class OverrideApp : Application() {
    companion object {
        private const val TAG = "OverrideApp"
    }

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "onCreate")
    }
}