import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// Bing Wallpaper for Linux
  ///
  /// In en, this message translates to:
  /// **'Bing Wallpaper for Linux'**
  String get app_name;

  /// Home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Library
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Feedback
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// Photo of the day
  ///
  /// In en, this message translates to:
  /// **'Photo of the day'**
  String get photo_of_the_day;

  /// Search from Web to learn more
  ///
  /// In en, this message translates to:
  /// **'Search from Web to learn more'**
  String get wallpaper_search_tips;

  /// Wallpaper
  ///
  /// In en, this message translates to:
  /// **'Wallpaper'**
  String get wallpaper;

  /// Convention
  ///
  /// In en, this message translates to:
  /// **'Convention'**
  String get convention;

  /// Widget
  ///
  /// In en, this message translates to:
  /// **'Widget'**
  String get widget;

  /// About
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Open
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// Close
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Refresh wallpaper daily
  ///
  /// In en, this message translates to:
  /// **'Refresh wallpaper daily'**
  String get settings_refresh_wallpaper_daily;

  /// Start to change daily images
  ///
  /// In en, this message translates to:
  /// **'Start to change daily images'**
  String get settings_refresh_wallpaper_daily_description;

  /// Display AI wallpaper
  ///
  /// In en, this message translates to:
  /// **'Display AI wallpaper'**
  String get settings_display_ai_wallpaper;

  /// Enable to display AI generated background images
  ///
  /// In en, this message translates to:
  /// **'Enable to display AI generated background images'**
  String get settings_display_ai_wallpaper_description;

  /// Right Corner
  ///
  /// In en, this message translates to:
  /// **'Right Corner'**
  String get settings_right_corner;

  /// Enable to learn more information about the background image
  ///
  /// In en, this message translates to:
  /// **'Click to learn more information about the background image'**
  String get settings_right_corner_description;

  /// Enable desktop to open Bing
  ///
  /// In en, this message translates to:
  /// **'Click on the desktop to open Bing'**
  String get settings_enable_desktop_to_open_bing;

  /// Enable desktop to open Bing
  ///
  /// In en, this message translates to:
  /// **'Bing Wallpaper for Linux'**
  String get settings_about;

  /// App development by Caiju Xu
  ///
  /// In en, this message translates to:
  /// **'App development by Caiju Xu'**
  String get settings_about_description;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
