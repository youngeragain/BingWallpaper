import 'WallpaperItem.dart';

abstract class WallpaperSourceData<I extends WallpaperItem> {
  int getDataLength();
  int getItemIndex(I? item);
  I? getItemByIndex(int index);
}