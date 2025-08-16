package xcj.app.flutter.bing_wallpaper

import android.app.WallpaperManager
import android.content.res.Configuration
import android.os.Bundle
import android.util.Log
import androidx.core.net.toUri
import androidx.core.view.WindowCompat
import androidx.lifecycle.lifecycleScope
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class MainActivity : FlutterActivity() {
    companion object {
        private const val TAG = "MainActivity"
    }

    private val CHANNEL = "xcj.app.flutter.wallpaper"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val insetsController = WindowCompat.getInsetsController(window, window.decorView)
        insetsController.isAppearanceLightStatusBars = true
        Log.d(TAG, "onCreate")
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            Log.d(
                TAG,
                "MethodCallHandler, call.method:${call.method}, call.arguments:${call.arguments}"
            )
            if (call.method == "setWallpaper") {
                val success = setWallpaper(call.arguments.toString())
                result.success(success)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun setWallpaper(localSystemUriString: String): Boolean {
        val wallpaperManager = WallpaperManager.getInstance(applicationContext)
        val uri = localSystemUriString.toUri()
        lifecycleScope.launch(Dispatchers.IO) {
            contentResolver.openInputStream(uri).use {
                wallpaperManager.setStream(it)
            }
        }
        return true
    }

    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
        Log.d(TAG, "onConfigurationChanged")
    }
}
