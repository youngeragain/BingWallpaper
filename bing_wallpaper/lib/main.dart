import 'package:bing_wallpaper/l10n/app_localizations.dart';
import 'package:bing_wallpaper/utils/GlobalSettings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'bing_wallpaper_starter.dart';

void main() async {
  await GlobalSettings.handleGlobal();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      onGenerateTitle: (context) {
        var RString = AppLocalizations.of(context)!;
        return RString.app_name;
      },
      theme: FluentThemeData(
        brightness: Brightness.light,
        accentColor: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const BingWallpaperStarterPage(),
    );
  }
}
