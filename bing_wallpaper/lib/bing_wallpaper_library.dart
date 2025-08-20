import 'package:bing_wallpaper/utils/LogUtil.dart';
import 'package:bing_wallpaper/utils/PlatfromUtil.dart';
import 'package:bing_wallpaper/wallpaper/WallpaperItem.dart';
import 'package:bing_wallpaper/wallpaper/WallpaperLibrary.dart';
import 'package:bing_wallpaper/wallpaper/WallpaperSource.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'l10n/app_localizations.dart';
import 'utils/Constants.dart';
import 'wallpaper/BingWallpaperFullSource.dart';
import 'wallpaper/BingWallpaperUpdateSource.dart';

class BingWallpaperLibraryPage extends StatefulWidget {
  const BingWallpaperLibraryPage({super.key});

  @override
  State<BingWallpaperLibraryPage> createState() =>
      _BingWallpaperLibraryPageState();
}

class _BingWallpaperLibraryPageState extends State<BingWallpaperLibraryPage>
    implements WallpaperSourceListener {
  static String _TAG = "_BingWallpaperLibraryPageState";
  final WallpaperLibrary _wallpaperLibrary = WallpaperLibrary();

  _BingWallpaperLibraryPageState() {
    var bingWallpaperUpdateSource = BingWallpaperUpdateSource(
      "https://raw.onmicrosoft.cn/Bing-Wallpaper-Action/main/data/zh-CN_update.json",
      sourceName: "Bing Update(CN)",
      listener: this,
    );
    var bingWallpaperFullSource = BingWallpaperFullSource(
      "https://raw.onmicrosoft.cn/Bing-Wallpaper-Action/main/data/zh-CN_all.json",
      sourceName: "Bing Full(CN)",
      listener: this,
    );
    _wallpaperLibrary.addSource(bingWallpaperUpdateSource);
    _wallpaperLibrary.addSource(bingWallpaperFullSource);
    _wallpaperLibrary.setCurrentSource(bingWallpaperUpdateSource, true);
  }

  @override
  void onLoadStart(WallpaperSource wallpaperSource) {
    Log.d(_TAG, "onLoadStart, wallpaperSource[${wallpaperSource.sourceName}]");
  }

  @override
  void onLoadFinish(WallpaperSource wallpaperSource) {
    Log.d(_TAG, "onLoadFinish, wallpaperSource[${wallpaperSource.sourceName}]");
    setState(() {});
  }

  @override
  void onLoadError(WallpaperSource wallpaperSource, Error e) {}

  @override
  void onCurrentItemChanged(WallpaperItem oldItem, WallpaperItem newItem) {}

  Future<void> onSourceSelectChanged(WallpaperSource wallpaperSource) async {
    Log.d(
      _TAG,
      "onSourceSelectChanged, wallpaperSource:${wallpaperSource.sourceName}",
    );
    _wallpaperLibrary.setCurrentSource(wallpaperSource, true);
    await onCurrentWallpaperChangedByUserTriggered(wallpaperSource.currentItem);
  }

  Future<void> setSpecifyAsWallpaper(
    WallpaperSource? wallpaperSource,
    WallpaperItem wallpaperItem,
  ) async {
    Log.d(_TAG, "setSpecifyAsWallpaper");
    wallpaperSource?.setCurrentItem(wallpaperItem);
    await onCurrentWallpaperChangedByUserTriggered(
      wallpaperSource?.currentItem,
    );
  }

  Future<void> setCurrentAsWallpaper(WallpaperSource? wallpaperSource) async {
    Log.d(_TAG, "setCurrentAsWallpaper");
    await onCurrentWallpaperChangedByUserTriggered(
      wallpaperSource?.currentItem,
    );
  }

  Future<void> showPreviousWallpaper(WallpaperSource? wallpaperSource) async {
    Log.d(_TAG, "showPreviousWallpaper");
    wallpaperSource?.changeToPreviousItem();
    await onCurrentWallpaperChangedByUserTriggered(
      wallpaperSource?.currentItem,
    );
  }

  Future<void> showNextWallpaper(WallpaperSource? wallpaperSource) async {
    Log.d(_TAG, "showNextWallpaper");
    wallpaperSource?.changeToNextItem();
    await onCurrentWallpaperChangedByUserTriggered(
      wallpaperSource?.currentItem,
    );
  }

  Future<void> onCurrentWallpaperChangedByUserTriggered(
    WallpaperItem? wallpaperItem,
  ) async {
    if (wallpaperItem != null) {
      await PlatformHelper.changeWallpaper(wallpaperItem);
    }
    setState(() {});
  }

  Widget buildTitleWidget() {
    var RString = AppLocalizations.of(context)!;
    return Text(
      RString.library,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    );
  }

  Widget buildTopWidget(
    List<WallpaperSource> allWallpaperSources,
    WallpaperSource? currentSource,
    void Function(WallpaperSource) onSourceSelected,
  ) {
    var dropDownButtons = <MenuFlyoutItem>[];
    for (var wallpaperSource in allWallpaperSources) {
      var item = MenuFlyoutItem(
        text: Text(wallpaperSource.sourceName),
        onPressed: () {
          onSourceSelected(wallpaperSource);
        },
      );
      dropDownButtons.add(item);
    }
    return DropDownButton(
      title: Text(currentSource?.sourceName ?? ""),
      items: dropDownButtons,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
    );
  }

  Widget buildCurrentSelectedWallpaperCardWidget(
    int dataLength,
    String wallpaperUrl,
    String title,
    String subTitle,
    void Function() onSelfClick,
    void Function() onPreviousClick,
    void Function() onNextClick,
  ) {
    var imageStackItems = <Widget>[];
    var imageWidget = GestureDetector(
      onTap: onSelfClick,
      child: CachedNetworkImage(
        imageUrl: wallpaperUrl,
        width: 360,
        height: 202,
        fit: BoxFit.scaleDown,
        progressIndicatorBuilder: (context, url, progress) {
          return Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 42,
                  height: 42,
                  child: ProgressRing(value: progress.progress),
                ),
              ),
            ],
          );
        },
        errorWidget: (context, url, error) => Icon(FluentIcons.error),
      ),
    );
    imageStackItems.add(imageWidget);
    if (dataLength > 1) {
      var showPreviousButton = Container(
        padding: const EdgeInsets.all(5.0),
        alignment: Alignment.centerLeft,
        child: Acrylic(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: IconButton(
              icon: const Icon(FluentIcons.caret_solid_left),
              onPressed: onPreviousClick,
            ),
          ),
        ),
      );
      imageStackItems.add(showPreviousButton);

      var showNextButton = Container(
        padding: const EdgeInsets.all(5.0),
        alignment: Alignment.centerRight,
        child: Acrylic(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: IconButton(
              icon: const Icon(FluentIcons.caret_solid_right),
              onPressed: onNextClick,
            ),
          ),
        ),
      );

      imageStackItems.add(showNextButton);
    }
    return SizedBox(
      width: 360,
      child: Card(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Stack(alignment: Alignment.center, children: imageStackItems),
            const Divider(),
            Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
            Text(subTitle),
          ],
        ),
      ),
    );
  }

  Widget buildWallpaperCardsWidget(
    WallpaperSource? wallpaperSource,
    void Function(WallpaperItem) onItemClick,
  ) {
    var RString = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 6,
      children: [
        Text(
          "${wallpaperSource?.sourceName ?? ""} ${RString.wallpaper}",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),

        SizedBox(
          width: 360,
          height: 360,
          child: Align(
            alignment: Alignment.topLeft,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: wallpaperSource?.sourceData?.getDataLength() ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 1.77,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (wallpaperSource == null) {
                      return;
                    }
                    var item = wallpaperSource.sourceData?.getItemByIndex(index);
                    if (item != null) {
                      onItemClick(item);
                    }
                  },
                  child: CachedNetworkImage(
                    imageUrl:
                    wallpaperSource?.sourceData
                        ?.getItemByIndex(index)
                        ?.getFullUrl() ??
                        "",
                    fit: BoxFit.scaleDown,
                    progressIndicatorBuilder: (context, url, progress) {
                      return Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 42,
                              height: 42,
                              child: ProgressRing(value: progress.progress),
                            ),
                          ),
                        ],
                      );
                    },
                    errorWidget: (context, url, error) => Icon(FluentIcons.error),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentSource = _wallpaperLibrary.currentSource;
    var allWallpaperSources = _wallpaperLibrary.allSource();
    var dataLength = currentSource?.sourceData?.getDataLength() ?? 0;
    var currentItem = currentSource?.currentItem;
    var currentSelectedWallpaperUrl = currentItem?.getFullUrl() ?? "";
    var currentSelectedWallpaperTitle = "";
    var currentSelectedWallpaperSubTitle = "";
    var copyright = currentSource?.currentItem?.copyright;
    if (copyright != null &&
        copyright.isNotEmpty &&
        copyright.contains(Constants.char_copyright)) {
      var indexOfCopyright = copyright.indexOf(Constants.char_copyright);
      currentSelectedWallpaperTitle = copyright.substring(
        0,
        indexOfCopyright - 1,
      );
      currentSelectedWallpaperSubTitle = copyright.substring(
        indexOfCopyright,
        copyright.length - 1,
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsetsGeometry.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: <Widget>[
            buildTitleWidget(),
            buildTopWidget(
              allWallpaperSources,
              currentSource,
              onSourceSelectChanged,
            ),
            buildCurrentSelectedWallpaperCardWidget(
              dataLength,
              currentSelectedWallpaperUrl,
              currentSelectedWallpaperTitle,
              currentSelectedWallpaperSubTitle,
              () {
                setCurrentAsWallpaper(currentSource);
              },
              () {
                showPreviousWallpaper(currentSource);
              },
              () {
                showNextWallpaper(currentSource);
              },
            ),
            SizedBox(height: 20),
            buildWallpaperCardsWidget(currentSource, (item) {
              setSpecifyAsWallpaper(currentSource, item);
            }),
          ],
        ),
      ),
    );
  }
}
