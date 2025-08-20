import 'dart:convert';

import 'package:bing_wallpaper/utils/LogUtil.dart';
import 'package:http/http.dart' as http;

import 'BingWallpaperFullData.dart';
import 'WallpaperSource.dart';

class BingWallpaperFullSource
    extends WallpaperSource<BingWallpaperFullData, FullImageData> {
  static const String _TAG = "BingWallpaperFullSource";
  static const String string_bing_http_prefix = "https://www.bing.com";

  String _dataSourceUrl;

  static String buildFullUrl(String? suffix) {
    if (suffix == null || suffix.isEmpty) {
      return "https://localhost";
    }
    return "$string_bing_http_prefix$suffix";
  }

  BingWallpaperFullSource(
    this._dataSourceUrl, {
    String? sourceName,
    WallpaperSourceLoadListener? loadListener,
    WallpaperItemChangedListener? itemChangedListener,
  }) : super(
         sourceName ?? "Bing",
         loadListener: loadListener,
         itemChangedListener: itemChangedListener,
       );

  @override
  void setSourceData(BingWallpaperFullData data) {
    super.setSourceData(data);
    var fistItem = data.data?.first;
    if (fistItem != null) {
      setCurrentItem(fistItem);
    }
  }

  @override
  void setCurrentItem(FullImageData item) {
    super.setCurrentItem(item);
  }

  @override
  void changeToNextItem() {
    var datas = sourceData?.data;
    if (datas == null || datas.isEmpty || datas.length == 1) {
      return;
    }
    var current = currentItem;
    if (current == null) {
      return;
    }
    var index = datas.indexOf(current);
    if (index == -1) {
      return;
    }
    FullImageData tempCurrentItem;
    if (index == datas.length - 1) {
      tempCurrentItem = datas.first;
    } else {
      tempCurrentItem = datas[index + 1];
    }

    setCurrentItem(tempCurrentItem);
  }

  @override
  void changeToPreviousItem() {
    var datas = sourceData?.data;
    if (datas == null || datas.isEmpty || datas.length == 1) {
      return;
    }
    var current = currentItem;
    if (current == null) {
      return;
    }
    var index = datas.indexOf(current);
    if (index == -1) {
      return;
    }
    FullImageData tempCurrentItem;
    if (index == 0) {
      tempCurrentItem = datas.last;
    } else {
      tempCurrentItem = datas[index - 1];
    }
    setCurrentItem(tempCurrentItem);
  }

  @override
  Future<void> loadData() async {
    if (sourceData != null) {
      return;
    }
    loadListener?.onLoadStart(this);
    http
        .get(Uri.parse(_dataSourceUrl))
        .then((response) {
          if (response.statusCode == 200) {
            // If the server did return a 200 OK response,
            // then parse the JSON.
            var bingWallpaperData = BingWallpaperFullData.fromJson(
              jsonDecode(response.body) as Map<String, dynamic>,
            );
            Log.d(_TAG, 'loadData, success to load bing wallpaper data');
            setSourceData(bingWallpaperData);
            loadListener?.onLoadFinish(this);
          } else {
            // If the server did not return a 200 OK response,
            // then throw an exception.
            Log.d(_TAG, 'loadData, failed to load bing wallpaper data');
          }
        })
        .catchError((e) {
          Log.d(
            _TAG,
            'loadData, failed to load bing wallpaper data with exception!$e，\ndataSourceUrl:$_dataSourceUrl',
          );
          loadListener?.onLoadError(this, e);
        });
  }
}
