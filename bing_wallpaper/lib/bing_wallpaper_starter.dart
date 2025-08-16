import 'package:bing_wallpaper/bing_wallpaper_settings.dart';
import 'package:bing_wallpaper/utils/LogUtil.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'bing_wallpaper_home.dart';
import 'bing_wallpaper_library.dart';
import 'l10n/app_localizations.dart';

class BingWallpaperStarterPage extends StatefulWidget {
  const BingWallpaperStarterPage({super.key});

  @override
  State<BingWallpaperStarterPage> createState() => _BingWallpaperStarterPageState();
}

class _BingWallpaperStarterPageState extends State<BingWallpaperStarterPage> {
  static String _TAG = "_BingWallpaperStarterPageState";

  int topIndex = 0;

  List<NavigationPaneItem> buildNavigationPanelItemsWidgets(){
    var RString = AppLocalizations.of(context)!;
    List<NavigationPaneItem> items = [
      PaneItem(
        icon: const Icon(FluentIcons.home),
        title: Text(RString.home),
        body: const BingWallpaperHomePage(),
      ),
      //PaneItemSeparator(),
      PaneItem(
        icon: const Icon(FluentIcons.library),
        title: Text(RString.library),
        body: const BingWallpaperLibraryPage(),
      )
    ];
    return items;
  }

  List<NavigationPaneItem> buildNavigationPanelFooterItemsWidgets(){
    var RString = AppLocalizations.of(context)!;
    List<NavigationPaneItem> footer_items = [
      PaneItem(
        icon: const Icon(FluentIcons.settings),
        title: Text(RString.settings),
        body: const BingWallpaperSettingsPage(),
      ),
      PaneItemAction(
        icon: const Icon(FluentIcons.feedback),
        title: Text(RString.feedback),
        onTap: () {
          onPanelActionItemTab(RString.feedback);
        },
      ),
    ];
    return footer_items;
  }

  void onPanelActionItemTab(tab){
    Log.d(_TAG, "onPanelActionItemTab, tab:$tab");
  }

  @override
  Widget build(BuildContext context) {
    var RString = AppLocalizations.of(context)!;
    return NavigationView(
      appBar: NavigationAppBar(
        title: Text(RString.app_name),
        automaticallyImplyLeading: false
      ),
      pane: NavigationPane(
        selected: topIndex,
        onItemPressed: (index) {
          if (index == topIndex) {

          }
        },
        onChanged: (index) => setState(() => topIndex = index),
        displayMode: PaneDisplayMode.compact,
        items: buildNavigationPanelItemsWidgets(),
        footerItems: buildNavigationPanelFooterItemsWidgets(),
      ),
    );
  }
}