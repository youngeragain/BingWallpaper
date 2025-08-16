import 'WallpaperItem.dart';
import 'WallpaperSourceData.dart';

abstract class WallpaperSourceLoadListener {
  void onLoadStart(WallpaperSource wallpaperSource);

  void onLoadFinish(WallpaperSource wallpaperSource);

  void onLoadError(WallpaperSource wallpaperSource, Error e);
}

abstract class WallpaperItemChangedListener {
  void onCurrentItemChanged();
}

abstract class WallpaperSource<D extends WallpaperSourceData, I extends WallpaperItem> {
  final String sourceName;
  D? sourceData;
  I? currentItem;

  WallpaperSourceLoadListener? loadListener;
  WallpaperItemChangedListener? itemChangedListener;

  WallpaperSource(
    this.sourceName, {
    this.loadListener,
    this.itemChangedListener,
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