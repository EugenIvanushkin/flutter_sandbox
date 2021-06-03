import 'package:flutter/foundation.dart';

enum NetworkDestination { test, esia }

extension NetworkDestinationExtension on NetworkDestination {
  static NetworkDestination fromBaseURL(String url) {
    for (var value in NetworkDestination.values) {
      if (value.checkURL(url)) return value;
    }
    return null;
  }

  String getURL() {
    final String environment = _getEnv();
    switch (this) {
      case NetworkDestination.test:
        return TestDestination.all[environment];
      case NetworkDestination.esia:
        return EsiaDestination.all[environment];
    }
    return null;
  }

  bool checkURL(String url) {
    switch (this) {
      case NetworkDestination.test:
        return TestDestination.all.values.contains((i) => url.contains(i));
      case NetworkDestination.esia:
        return EsiaDestination.all.values.contains((i) => url.contains(i));
    }
    return false;
  }

  String _getEnv() {
    if (kDebugMode) {
      return EsiaDestination.DEBUG;
    }

    switch (this) {
      case NetworkDestination.test:
        return TestDestination.RELEASE;
      case NetworkDestination.esia:
        return EsiaDestination.RELEASE;
    }

    return null;
  }
}

// TEST ENV

const String _TEST_DEBUG = "https://randomuser.me/api/";
const String _TEST_RELEASE = "https://randomuser.me/api/";

class TestDestination {
  static const String prefKey = "TEST_ENVIRONMENT";
  static const Map<String, String> all = {
    DEBUG: _TEST_DEBUG,
    RELEASE: _TEST_RELEASE
  };

  // ignore: non_constant_identifier_names
  static const String DEBUG = "DEBUG";

  // ignore: non_constant_identifier_names
  static const String RELEASE = "RELEASE";
}

// ESIA TEST ENV

const String _ESIA_DEBUG = "https://esia-dev.test.gosuslugi.ru/";
const String _ESIA_RELEASE = "https://esia-dev.test.gosuslugi.ru/";

class EsiaDestination {
  static const String prefKey = "ESIA_ENVIRONMENT";
  static const Map<String, String> all = {
    DEBUG: _ESIA_DEBUG,
    RELEASE: _ESIA_RELEASE
  };

  // ignore: non_constant_identifier_names
  static const String DEBUG = "DEBUG";

  // ignore: non_constant_identifier_names
  static const String RELEASE = "RELEASE";
}
