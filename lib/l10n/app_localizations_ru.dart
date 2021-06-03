
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get titlePageDashboard => 'Мониторинг';

  @override
  String get titlePageNews => 'Новости';

  @override
  String get titlePincode => 'Установить пинкод';

  @override
  String get pincodeFirstStep => 'Введите пинкод';

  @override
  String get pincodeSecondStep => 'Повторите пинкод';

  @override
  String get setBiometryAlertTitle => 'Хотите юзать биометрию?';

  @override
  String get setBiometryAlertMessage => 'Поюзайте биометрию. Но можете и не юзать.';

  @override
  String get setBiometryAlertYes => 'Ага';

  @override
  String get setBiometryAlertNo => 'Не ага';

  @override
  String get logoutAlertTitle => 'Подтверждение выхода';

  @override
  String get logoutAlertMessage => 'Вы действительно уверены, что хотите выйти из учетной записи?';

  @override
  String get logoutAlertYes => 'Ага';

  @override
  String get logoutAlertNo => 'Не ага';

  @override
  String get commonError => 'Something went wrong...';

  @override
  String get missingTokenError => 'Token is missing, you need to log in again.';

  @override
  String pincodeAttemptAlert(Object attemptLeftCount) {
    return 'There are ${attemptLeftCount} attempts left, otherwise logout.';
  }

  @override
  String get bioDeletedError => 'Пинкод, который охранялся биометрической аутентификацией исчез, сори.';

  @override
  String get bioDisableError => 'Биометрическая аутентификация отключена в настройках, хочешь ей пользоваться - иди в настройки и включи.';

  @override
  String get bioNotEnrolledError => 'Биометрическая аутентификация не включена в настройках, можешь пошарить там сам.';

  @override
  String get appSettingsAlertTitle => 'Хотите залезть в настройки?';

  @override
  String get appSettingsAlertMessage => 'Уникальная возможность там чего-нибудь покрутить!';

  @override
  String get appSettingsAlertNo => 'Обойдусь';

  @override
  String get appSettingsAlertYes => 'НАСТРОЙКИ МОИ НАСТРОЙКИ';
}
