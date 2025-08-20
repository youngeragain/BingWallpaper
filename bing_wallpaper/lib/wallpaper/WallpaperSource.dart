import 'WallpaperItem.dart';
import 'WallpaperSourceData.dart';

abstract class WallpaperSourceListener {
  void onLoadStart(WallpaperSource wallpaperSource);

  void onLoadFinish(WallpaperSource wallpaperSource);

  void onLoadError(WallpaperSource wallpaperSource, Error e);

  void onCurrentItemChanged(WallpaperItem oldItem, WallpaperItem newItem);
}


abstract class WallpaperSource<D extends WallpaperSourceData, I extends WallpaperItem> {
  final String sourceName;
  D? sourceData;
  I? currentItem;

  WallpaperSourceListener? listener;

  WallpaperSource(
    this.sourceName, {
    this.listener
  });

  void setSourceData(D data) {
    sourceData = data;
  }

  void setCurrentItem(I item) {
    currentItem = item;
  }

  void changeToNextItem();

  void changeToPreviousItem();

  Future<void> loadData();
}