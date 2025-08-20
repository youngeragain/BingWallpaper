import 'dart:io';

import 'HttpUtil.dart';

class GlobalSettings{
  static Future<void> handleGlobal() async {
    HttpOverrides.global = MyHttpOverrides();
  }
}