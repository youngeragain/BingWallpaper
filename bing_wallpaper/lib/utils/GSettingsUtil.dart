import 'dart:io';

import 'package:dbus/dbus.dart';
import 'package:gsettings/gsettings.dart';

import 'LogUtil.dart';

class GSettingsHelper {
  static const String _TAG = "GSettings";

  static void changeWallpaper(uri) {
    Log.d(_TAG, "changeWallpaper, uri:$uri");
    if (Platform.isLinux) {
      var gsettings_background = GSettings('org.gnome.desktop.background');
      DBusValue pictureUri = DBusString(uri);
      gsettings_background
          .set('picture-uri', pictureUri)
          .whenComplete(() {
            Log.d(_TAG, "ChangeWallpaper Success");
          })
          .catchError((e) {
            Log.d(_TAG, "ChangeWallpaper Failure");
          });
    }
  }
}
