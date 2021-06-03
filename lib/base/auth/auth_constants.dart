import 'dart:io';

class AuthConstants {
  AuthConstants._();

  static const appName = "testGosuslugi";
  static const scopeIOS = "openid";
  static const scopeAndroid =
      "openid fullname birthdate gender snils inn contacts usr_org";
  static const clientIdentifier = "TESTGUSLUGI";
  static const redirectUriIOS = "https://esia-dev.test.gosuslugi.ru";
  static const redirectUriAndroid = "http://mercury.it.ru:7078/samlpostlogin";

  static const authCodeKey = "authCode";

  static String get scope => Platform.isAndroid ? scopeAndroid : scopeIOS;
  static String get redirectUri =>
      Platform.isAndroid ? redirectUriAndroid : redirectUriIOS;
}
