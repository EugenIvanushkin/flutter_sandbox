
import 'dart:async';

// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
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
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: 0.16.1
///
///   # rest of dependencies
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
  AppLocalizations(String locale) : assert(locale != null), localeName = intl.Intl.canonicalizedLocale(locale.toString());

  // ignore: unused_field
  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ru')
  ];

  // No description provided in @titlePageDashboard
  String get titlePageDashboard;

  // News page title
  String get titlePageNews;

  // No description provided in @titlePincode
  String get titlePincode;

  // No description provided in @pincodeFirstStep
  String get pincodeFirstStep;

  // No description provided in @pincodeSecondStep
  String get pincodeSecondStep;

  // No description provided in @setBiometryAlertTitle
  String get setBiometryAlertTitle;

  // No description provided in @setBiometryAlertMessage
  String get setBiometryAlertMessage;

  // No description provided in @setBiometryAlertYes
  String get setBiometryAlertYes;

  // No description provided in @setBiometryAlertNo
  String get setBiometryAlertNo;

  // No description provided in @logoutAlertTitle
  String get logoutAlertTitle;

  // No description provided in @logoutAlertMessage
  String get logoutAlertMessage;

  // No description provided in @logoutAlertYes
  String get logoutAlertYes;

  // No description provided in @logoutAlertNo
  String get logoutAlertNo;

  // No description provided in @commonError
  String get commonError;

  // No description provided in @missingTokenError
  String get missingTokenError;

  // No description provided in @pincodeAttemptAlert
  String pincodeAttemptAlert(Object attemptLeftCount);

  // No description provided in @bioDeletedError
  String get bioDeletedError;

  // No description provided in @bioDisableError
  String get bioDisableError;

  // No description provided in @bioNotEnrolledError
  String get bioNotEnrolledError;

  // No description provided in @appSettingsAlertTitle
  String get appSettingsAlertTitle;

  // No description provided in @appSettingsAlertMessage
  String get appSettingsAlertMessage;

  // No description provided in @appSettingsAlertNo
  String get appSettingsAlertNo;

  // No description provided in @appSettingsAlertYes
  String get appSettingsAlertYes;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(_lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations _lookupAppLocalizations(Locale locale) {
  
  
  
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru': return AppLocalizationsRu();
  }

  assert(false, 'AppLocalizations.delegate failed to load unsupported locale "$locale"');
  return null;
}
