import 'dart:collection';

import 'package:bing_wallpaper/utils/Constants.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_localizations.dart';

class BingWallpaperSettingsPage extends StatefulWidget {
  const BingWallpaperSettingsPage({super.key});

  @override
  State<BingWallpaperSettingsPage> createState() =>
      _BingWallpaperSettingsPageState();
}

abstract class _SettingsItem {
  String key;
  String name;
  String? description;
  String groupName;
  String type;

  _SettingsItem(
    this.key,
    this.name,
    this.description,
    this.groupName,
    this.type,
  );
}

class _SettingsItemOfSwitch extends _SettingsItem {
  bool isOpen = false;

  _SettingsItemOfSwitch(key, name, description, groupName)
    : super(key, name, description, groupName, "switch");

  void updateOpenStatus(bool checked) {
    isOpen = checked;
  }
}

class _SettingsItemOfText extends _SettingsItem {
  String content;

  _SettingsItemOfText(key, name, description, groupName, this.content)
    : super(key, name, description, groupName, "text");
}

class _BingWallpaperSettingsPageState extends State<BingWallpaperSettingsPage> {
  List<_SettingsItem> settingsItems = [];

  _BingWallpaperSettingsPageState() {}

  Future<void> _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var lastSettingsItem = settingsItems.last as _SettingsItemOfText?;
    if (lastSettingsItem == null) {
      return;
    }
    lastSettingsItem.content = packageInfo.version;
    setState(() {});
  }

  Widget buildTitle() {
    var RString = AppLocalizations.of(context)!;
    return Text(
      RString.settings,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    );
  }

  Future<void> onSettingsItemCheckChanged(
    _SettingsItemOfSwitch settingsItem,
    bool checked,
  ) async {
    settingsItem.updateOpenStatus(checked);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(settingsItem.key, checked);
    setState(() {});
  }

  Future<void> buildSettingsItemsIfNeeded() async {
    if (settingsItems.isEmpty && context.mounted) {
      var prefs = await SharedPreferences.getInstance();
      var RString = AppLocalizations.of(context)!;
      var settingsItem1 = _SettingsItemOfSwitch(
        Constants.string_key_settings_refresh_wallpaper_daily,
        RString.settings_refresh_wallpaper_daily,
        RString.settings_refresh_wallpaper_daily_description,
        RString.convention,
      );
      settingsItem1.updateOpenStatus(prefs.getBool(settingsItem1.key) ?? false);
      settingsItems.add(settingsItem1);

      var settingsItem2 = _SettingsItemOfSwitch(
        Constants.string_key_settings_display_ai_wallpaper,
        RString.settings_display_ai_wallpaper,
        RString.settings_display_ai_wallpaper_description,
        RString.convention,
      );
      settingsItem2.updateOpenStatus(prefs.getBool(settingsItem2.key) ?? false);
      settingsItems.add(settingsItem2);

      var settingsItem3 = _SettingsItemOfSwitch(
        Constants.string_key_settings_right_corner,
        RString.settings_right_corner,
        RString.settings_right_corner_description,
        RString.widget,
      );
      settingsItem3.updateOpenStatus(prefs.getBool(settingsItem3.key) ?? false);
      settingsItems.add(settingsItem3);

      var settingsItem4 = _SettingsItemOfSwitch(
        Constants.string_key_settings_click_desktop_to_open_bing,
        RString.settings_enable_desktop_to_open_bing,
        null,
        RString.widget,
      );
      settingsItem4.updateOpenStatus(prefs.getBool(settingsItem4.key) ?? false);
      settingsItems.add(settingsItem4);

      var settingsItem5 = _SettingsItemOfText(
        Constants.string_key_nothing,
        RString.settings_about,
        RString.settings_about_description,
        RString.about,
        "",
      );
      settingsItems.add(settingsItem5);
      _getAppVersion();
    }
  }

  Widget buildSettingsWidget(
    void Function(_SettingsItemOfSwitch, bool) onSettingsItemCheckChanged,
  ) {
    buildSettingsItemsIfNeeded();
    List<Widget> columItems = [];
    LinkedHashMap<String, List<_SettingsItem>> map = LinkedHashMap();
    for (final item in settingsItems) {
      if (map.containsKey(item.groupName)) {
        map[item.groupName]?.add(item);
      } else {
        map[item.groupName] = [item];
      }
    }
    map.forEach((groupName, settingsItems) {
      columItems.add(Text(groupName));
      for (var item in settingsItems) {
        if (item is _SettingsItemOfSwitch) {
          var switchWidget = buildSettingsItemOfSwitchWidget(
            item,
            onSettingsItemCheckChanged,
          );
          columItems.add(switchWidget);
        } else if (item is _SettingsItemOfText) {
          var textWidget = buildSettingsItemOfTextWidget(item);
          columItems.add(textWidget);
        }
      }
    });
    return SizedBox(
      width: 360,
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columItems,
      ),
    );
  }

  Widget buildSettingsItemOfSwitchWidget(
    _SettingsItemOfSwitch item,
    void Function(_SettingsItemOfSwitch, bool) onSettingsItemCheckChanged,
  ) {
    var RString = AppLocalizations.of(context)!;
    var leftColumItems = <Widget>[Text(item.name)];
    var description = item.description;
    if (description != null && description.isNotEmpty) {
      leftColumItems.add(
        Text(description, maxLines: 1, overflow: TextOverflow.ellipsis),
      );
    }
    var openStatusText = "";
    if (item.isOpen) {
      openStatusText = RString.open;
    } else {
      openStatusText = RString.close;
    }
    return Card(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 68,
        padding: EdgeInsets.all(6),
        child: Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 180,
              child: Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: leftColumItems,
              ),
            ),
            Spacer(),
            Text(openStatusText),
            ToggleSwitch(
              checked: item.isOpen,
              onChanged: (checked) {
                onSettingsItemCheckChanged(item, checked);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsItemOfTextWidget(_SettingsItemOfText item) {
    var leftColumItems = <Widget>[Text(item.name)];
    var description = item.description;
    if (description != null && description.isNotEmpty) {
      leftColumItems.add(
        Text(description, maxLines: 1, overflow: TextOverflow.ellipsis),
      );
    }
    return Card(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 68,
        padding: EdgeInsets.all(6),
        child: Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 180,
              child: Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: leftColumItems,
              ),
            ),
            Spacer(),
            Text(item.content),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsetsGeometry.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: <Widget>[
            buildTitle(),
            buildSettingsWidget(onSettingsItemCheckChanged),
          ],
        ),
      ),
    );
  }
}
