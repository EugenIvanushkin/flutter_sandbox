import 'package:flutter/scheduler.dart';
import 'package:flutter_sample/base/app/redux_app.dart';

const String DASHBOARD = "/dashboard";
const String NEWS = "/news";
const String PINCODE = "/pincode";
const String AUTH = "/auth";

const Set ROUTES = {AUTH, PINCODE};
const Set AUTHORIZED_ROUTES = {DASHBOARD, NEWS};

class RouteInfo {
  bool isValid;
  bool isAuthorized;

  RouteInfo(this.isValid, this.isAuthorized);
}

RouteInfo checkRoute(String route) {
  var routes = route.split('/');
  bool isValid = true;
  bool isAuthorized = false;
  for (var value in routes) {
    if (value.isNotEmpty) {
      if (!ROUTES.contains("/$value")) isValid = false;
      if (AUTHORIZED_ROUTES.contains("/$value")) isAuthorized = true;
    }
  }
  return RouteInfo(isValid, isAuthorized);
}

Future<bool> navigateWithRoute(String route) async {
  var routeInfo = checkRoute(route);
  if (!routeInfo.isValid) return false;
  if (routeInfo.isAuthorized && !true) return false;

  var routes = route.split('/');
  for (var value in routes) {
    if (value.isNotEmpty) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FlutterReduxApp.navigatorKey.currentState.pushNamed('/' + value);
      });
    }
  }
  return true;
}

navigateWithDeeplink(Uri deeplink) async {
  // todo maybe map deeplink path to app route
  if (!deeplink.hasQuery)
    navigateWithRoute(deeplink.path);
  else {
    var params = deeplink.queryParameters;
    // todo add constructing routes with query params
  }
}
