import 'package:bing_wallpaper/utils/AppSettings.dart';
import 'package:bing_wallpaper/wallpaper/WallpaperItem.dart';
import 'package:bing_wallpaper/utils/LogUtil.dart';
import 'package:bing_wallpaper/utils/PlatfromUtil.dart';
import 'package:bing_wallpaper/wallpaper/WallpaperSource.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'wallpaper/BingWallpaperUpdateSource.dart';
import 'utils/Constants.dart';
import 'l10n/app_localizations.dart';

class BingWallpaperHomePage extends StatefulWidget {
  const BingWallpaperHomePage({super.key});

  @override
  State<BingWallpaperHomePage> createState() => _BingWallpaperHomePageState();
}

class _BingWallpaperHomePageState extends State<BingWallpaperHomePage>
    implements WallpaperSourceLoadListener {
  static const String _TAG = "_BingWallpaperHomePageState";

  late WallpaperSource _wallpaperSource;

  _BingWallpaperHomePageState() {
    var bingWallpaperFullSource = BingWallpaperUpdateSource(
      "https://raw.onmicrosoft.cn/Bing-Wallpaper-Action/main/data/zh-CN_update.json",
      sourceName: "Bing Update(CN)",
      loadListener: this,
    );
    _wallpaperSource = bingWallpaperFullSource;
    _wallpaperSource.loadData();
  }

  void openBrowserToShowWallpaperTipWebContent() {
    var wallpaperSource = _wallpaperSource;
    var wallpaperItem = wallpaperSource.currentItem;
    if (wallpaperItem == null) {
      return;
    }

    final Uri url = Uri.parse(wallpaperItem.getFullUrl());
    Log.d(_TAG, "openBrowserToShowWallpaperTipWebContent, url:$url");
    launchUrl(url, mode: LaunchMode.externalApplication).catchError((e) {
      Log.d(_TAG, "openBrowserToShowWallpaperTipWebContent, failed:$e");
      return true;
    });
  }

  @override
  void onLoadStart(WallpaperSource wallpaperSource) {
    Log.d(_TAG, "onLoadStart, wallpaperSource[${wallpaperSource.sourceName}]");
  }

  @override
  void onLoadFinish(WallpaperSource wallpaperSource) {
    Log.d(_TAG, "onLoadFinish, wallpaperSource[${wallpaperSource.sourceName}]");
    setState(() {});
    AppSettings.changeWallpaperForDailyWhenSettingsEnableIfNeeded(
      "home_data_onLoadFinish",
      wallpaperSource.currentItem,
    );
  }

  @override
  void onLoadError(WallpaperSource wallpaperSource, Error e) {}

  Future<void> setSpecifyAsWallpaper(
    WallpaperSource wallpaperSource,
    WallpaperItem wallpaperItem,
  ) async {
    Log.d(_TAG, "setSpecifyAsWallpaper");
    wallpaperSource.setCurrentItem(wallpaperItem);
    await onCurrentWallpaperChangedByUserTriggered(wallpaperSource.currentItem);
  }

  Future<void> setCurrentAsWallpaper(WallpaperSource wallpaperSource) async {
    Log.d(_TAG, "setCurrentAsWallpaper");
    await onCurrentWallpaperChangedByUserTriggered(wallpaperSource.currentItem);
  }

  Future<void> showPreviousWallpaper(WallpaperSource wallpaperSource) async {
    Log.d(_TAG, "showPreviousWallpaper");
    wallpaperSource.changeToPreviousItem();
    await onCurrentWallpaperChangedByUserTriggered(wallpaperSource.currentItem);
  }

  Future<void> showNextWallpaper(WallpaperSource wallpaperSource) async {
    Log.d(_TAG, "showNextWallpaper");
    wallpaperSource.changeToNextItem();
    await onCurrentWallpaperChangedByUserTriggered(wallpaperSource.currentItem);
  }

  Future<void> onCurrentWallpaperChangedByUserTriggered(
    WallpaperItem? wallpaperItem,
  ) async {
    if (wallpaperItem == null) {
      return;
    }
    await PlatformHelper.changeWallpaper(wallpaperItem);
    setState(() {});
  }

  Widget buildTitleWidget() {
    var RString = AppLocalizations.of(context)!;
    return Text(
      RString.home,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    );
  }

  Widget buildTopWidget(WallpaperSource? wallpaperSource) {
    var RString = AppLocalizations.of(context)!;
    var dataLength = wallpaperSource?.sourceData?.getDataLength() ?? 0;
    var currentItem = wallpaperSource?.currentItem;
    var currentItemIndex =
        wallpaperSource?.sourceData?.getItemIndex(currentItem) ?? -1;
    var dateStringBuffer = StringBuffer("");
    var currentItemEndDate = currentItem?.enddate;
    if (currentItemEndDate != null && currentItemEndDate.length == 8) {
      dateStringBuffer
        ..write(currentItemEndDate.substring(0, 4))
        ..write("/")
        ..write(currentItemEndDate.substring(4, 6))
        ..write("/")
        ..write(currentItemEndDate.substring(6));
    }
    var dateString = dateStringBuffer.toString();
    return SizedBox(
      width: 360,
      child: Row(
        children: [
          Text("${RString.photo_of_the_day} | $dateString"),
          Spacer(),
          Text("${(currentItemIndex + 1)} / $dataLength"),
        ],
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

  Widget buildWallpaperTipsCardWidget(WallpaperSource wallpaperSource) {
    var wallpaperItem = wallpaperSource.currentItem;
    var RString = AppLocalizations.of(context)!;
    return SizedBox(
      width: 360,
      child: Card(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              wallpaperItem?.title ?? "",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            FilledButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              onPressed: openBrowserToShowWallpaperTipWebContent,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  spacing: 12,
                  children: [
                    Icon(FluentIcons.search),
                    Text(RString.wallpaper_search_tips),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentSource = _wallpaperSource;
    var dataLength = currentSource.sourceData?.getDataLength() ?? 0;
    var currentItem = currentSource.currentItem;
    var currentSelectedWallpaperUrl = currentItem?.getFullUrl() ?? "";
    var currentSelectedWallpaperTitle = "";
    var currentSelectedWallpaperSubTitle = "";
    var copyright = currentSource.currentItem?.copyright;
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
            buildTopWidget(currentSource),
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
            buildWallpaperTipsCardWidget(currentSource),
          ],
        ),
      ),
    );
  }
}
