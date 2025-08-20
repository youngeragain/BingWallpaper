import 'dart:convert';

import 'package:http/http.dart' as http;

import 'BingWallpaperSource.dart';
import 'BingWallpaperUpdateData.dart';
import 'WallpaperSource.dart';

class BingWallpaperUpdateSource
    extends BingWallpaperSource<BingWallpaperUpdateData, UpdateImageData> {
  static const String _TAG = "BingWallpaperUpdateSource";

  BingWallpaperUpdateSource(
    dataSourceUrl, {
    String? sourceName,
    WallpaperSourceListener? listener,
  }) : super(
         dataSourceUrl,
         sourceName: sourceName ?? "Bing",
         listener: listener,
       );

  @override
  BingWallpaperUpdateData parseDataFromResponse(http.Response response) {
    return BingWallpaperUpdateData.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
