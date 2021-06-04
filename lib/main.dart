import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/auth/auth_page.dart';
import 'package:flutter_sample/pages/dashboard/dashboard_page.dart';
import 'package:flutter_sample/pages/news/news_page.dart';
import 'package:flutter_sample/pages/splash/splash_page.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

import 'base/app/redux/store.dart';
import 'base/app/redux_app.dart';
import 'base/navigation/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final store = await AppStoreCreator().createReduxStore();

  Crashlytics.instance.enableInDevMode = false;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  getUriLinksStream().listen((Uri uri) {
    if (uri != null) navigateWithDeeplink(uri);
  }, onError: (err) {});

  runApp(MyApp(store));
}

class MyApp extends FlutterReduxApp {
  MyApp(Store store) : super(store);

  @override
  Map<String, WidgetBuilder> getRoutes(AppVM viewModel) {
    return {
      '/': (context) => SplashPage(viewModel.routeToRestore),
      DASHBOARD: (context) => DashboardPage(),
      NEWS: (context) => NewsPage(),
      AUTH: (context) => AuthPage()
    };
  }
}
