import 'package:bing_wallpaper/utils/Constants.dart';
import 'package:bing_wallpaper/wallpaper/WallpaperItem.dart';
import 'package:bing_wallpaper/utils/LogUtil.dart';
import 'package:bing_wallpaper/utils/PlatfromUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static const _TAG = "AppSettings";

  static Future<void> changeWallpaperForDailyWhenSettingsEnableIfNeeded(
    String by,
    WallpaperItem? wallpaperItem,
  ) async {
    Log.d(_TAG, "changeWallpaperForDailyWhenSettingsEnableIfNeeded by:$by");
    if (wallpaperItem == null) {
      return;
    }
    var prefs = await SharedPreferences.getInstance();
    var shouldChangeWallpaperDaily =
        prefs.getBool(Constants.string_key_settings_refresh_wallpaper_daily) ??
        false;
    if (shouldChangeWallpaperDaily) {
      PlatformHelper.changeWallpaper(wallpaperItem);
    }
  }
}
