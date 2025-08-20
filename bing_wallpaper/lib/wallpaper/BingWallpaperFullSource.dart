import 'dart:convert';

import 'package:bing_wallpaper/wallpaper/BingWallpaperSource.dart';
import 'package:http/http.dart' as http;

import 'BingWallpaperFullData.dart';
import 'WallpaperSource.dart';

class BingWallpaperFullSource
    extends BingWallpaperSource<BingWallpaperFullData, FullImageData> {
  static const String _TAG = "BingWallpaperFullSource";

  BingWallpaperFullSource(
    dataSourceUrl, {
    String? sourceName,
    WallpaperSourceListener? listener,
  }) : super(
         dataSourceUrl,
         sourceName: sourceName ?? "Bing",
         listener: listener,
       );

  @override
  BingWallpaperFullData parseDataFromResponse(http.Response response) {
    return BingWallpaperFullData.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
