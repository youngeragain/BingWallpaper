import 'WallpaperItem.dart';

abstract class WallpaperSourceData<I extends WallpaperItem> {
  List<I>? items();
  int getDataLength(){
    return items()?.length??0;
  }
  int getItemIndex(I? item);
  I? getItemByIndex(int index);
}