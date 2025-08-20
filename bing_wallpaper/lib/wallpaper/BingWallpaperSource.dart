import 'package:bing_wallpaper/utils/LogUtil.dart';
import 'package:http/http.dart' as http;

import 'WallpaperItem.dart';
import 'WallpaperSource.dart';
import 'WallpaperSourceData.dart';

abstract class BingWallpaperSource<
  D extends WallpaperSourceData,
  I extends WallpaperItem
>
    extends WallpaperSource<D, I> {
  static const String _TAG = "BingWallpaperSource";
  static const String string_bing_http_prefix = "https://www.bing.com";

  String _dataSourceUrl;

  static String buildFullUrl(String? suffix) {
    if (suffix == null || suffix.isEmpty) {
      return "https://localhost";
    }
    return "$string_bing_http_prefix$suffix";
  }

  BingWallpaperSource(
    this._dataSourceUrl, {
    String? sourceName,
    WallpaperSourceListener? listener,
  }) : super(sourceName ?? "Bing", listener: listener);

  @override
  void setSourceData(D data) {
    super.setSourceData(data);
    var fistItem = data.items()?.first;
    if (fistItem != null) {
      setCurrentItem(fistItem as I);
    }
  }

  @override
  void setCurrentItem(I item) {
    super.setCurrentItem(item);
  }

  @override
  void changeToNextItem() {
    var items = sourceData?.items();
    if (items == null || items.isEmpty || items.length == 1) {
      return;
    }
    var current = currentItem;
    if (current == null) {
      return;
    }
    var index = items.indexOf(current);
    if (index == -1) {
      return;
    }
    WallpaperItem? tempCurrentItem;
    if (index == items.length - 1) {
      tempCurrentItem = items.first;
    } else {
      tempCurrentItem = items[index + 1];
    }

    setCurrentItem(tempCurrentItem as I);
  }

  @override
  void changeToPreviousItem() {
    var items = sourceData?.items();
    if (items == null || items.isEmpty || items.length == 1) {
      return;
    }
    var current = currentItem;
    if (current == null) {
      return;
    }
    var index = items.indexOf(current);
    if (index == -1) {
      return;
    }
    WallpaperItem tempCurrentItem;
    if (index == 0) {
      tempCurrentItem = items.last;
    } else {
      tempCurrentItem = items[index - 1];
    }
    setCurrentItem(tempCurrentItem as I);
  }

  @override
  Future<void> loadData() async {
    if (sourceData != null) {
      return;
    }
    listener?.onLoadStart(this);
    http
        .get(Uri.parse(_dataSourceUrl))
        .then((response) {
          if (response.statusCode == 200) {
            // If the server did return a 200 OK response,
            // then parse the JSON.
            var bingWallpaperData = parseDataFromResponse(response);
            Log.d(_TAG, 'loadData, success to load bing wallpaper data');
            setSourceData(bingWallpaperData);
            listener?.onLoadFinish(this);
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
          listener?.onLoadError(this, e);
        });
  }

  D parseDataFromResponse(http.Response response);
}
