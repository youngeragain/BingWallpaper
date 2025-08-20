import 'dart:io';

import 'package:bing_wallpaper/utils/LogUtil.dart';
import 'package:flutter/services.dart';

import '../wallpaper/WallpaperItem.dart';
import 'CacheUtil.dart';
import 'GSettingsUtil.dart';

class PlatformHelper {
  static const _TAG = "PlatformHelper";
  static const platform = MethodChannel('xcj.app.flutter.wallpaper');

  static Future<void> changeWallpaper(WallpaperItem wallpaperItem) async {
    var url = wallpaperItem.getFullUrl();
    var urlImageCacheFile = await CacheHelper.getImageCacheFile(url);
    if (urlImageCacheFile == null) {
      return;
    }
    var localSystemUriString = urlImageCacheFile.uri.toString();
    Log.d(_TAG, "changeWallpaper, localSystemUriString:$localSystemUriString");
    if (Platform.isAndroid) {
      Log.d(_TAG, "changeWallpaper, for Android");
      await platform.invokeMethod<bool>("setWallpaper", localSystemUriString);
    } else if (Platform.isIOS) {
      Log.d(_TAG, "changeWallpaper, for iOS");
    } else if (Platform.isWindows) {
      Log.d(_TAG, "changeWallpaper, for Windows");
    } else if (Platform.isMacOS) {
      Log.d(_TAG, "changeWallpaper, for MacOS");
    } else if (Platform.isLinux) {
      Log.d(_TAG, "changeWallpaper, for Linux");
      GSettingsHelper.changeWallpaper(localSystemUriString);
    } else if (Platform.isFuchsia) {
      Log.d(_TAG, "changeWallpaper, for Fuchsia");
    }
  }
}
