import 'WallpaperSource.dart';

abstract class LibrarySourceChangedListener {
  void onSourceChanged();

  void onCurrentSourceChanged(WallpaperSource wallpaperSource);
}

class WallpaperLibrary {
  List<WallpaperSource> _sources = [];

  WallpaperSource? currentSource;

  LibrarySourceChangedListener? listener;

  WallpaperLibrary({this.listener});

  List<WallpaperSource> allSource() {
    return _sources;
  }

  void addSource(WallpaperSource wallpaperSource) {
    _sources.add(wallpaperSource);
  }

  void removeSource(WallpaperSource wallpaperSource) {
    _sources.remove(wallpaperSource);
  }

  void removeSourceByName(String sourceName) {
    _sources.removeWhere((t) {
      return t.sourceName == sourceName;
    });
  }

  WallpaperSource? findSourceByName(String sourceName) {
    return _sources.firstWhere((wallpaperSource) {
      return wallpaperSource.sourceName == sourceName;
    });
  }

  void setCurrentSource(WallpaperSource wallpaperSource, bool load) {
    currentSource = wallpaperSource;
    if (load) {
      wallpaperSource.loadData();
    }
    listener?.onCurrentSourceChanged(wallpaperSource);
  }
}