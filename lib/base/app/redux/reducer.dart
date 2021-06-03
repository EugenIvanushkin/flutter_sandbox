

import 'package:flutter_sample/base/app/redux/state.dart';

import 'action.dart';

AppState appReducers(AppState state, dynamic action) {
  if (action is PushRouteAction) {
    return pushRoute(state, action);
  } else if (action is PopRouteAction) {
    return popRoute(state, action);
  } else if (action is RemoveRouteAction) {
    return removeRoute(state, action);
  } else if (action is ReplaceRouteAction) {
    return replaceRoute(state, action);
  }
  return state;
}

AppState pushRoute(AppState state, PushRouteAction action) {
  if (action.newRoute == '/' || action.newRoute == null) return state;
  var previousRote = state.route;
  if (previousRote == null) previousRote = '';
  return AppState(previousRote + action.newRoute);
}

AppState popRoute(AppState state, PopRouteAction action) {
  var previousRote = state.route;
  var index = previousRote.lastIndexOf('/');
  if (index < 0) return state;
  var newRoute = previousRote.substring(0, previousRote.lastIndexOf('/'));
  return AppState(newRoute);
}

AppState removeRoute(AppState state, RemoveRouteAction action) {
  if (action.removedRoute == '/' || action.removedRoute == null) return state;
  var previousRote = state.route;
  var newRoute = previousRote.replaceAll(action.removedRoute, '');
  return AppState(newRoute);
}

AppState replaceRoute(AppState state, ReplaceRouteAction action) {
  var previousRote = state.route;
  if (previousRote == null) previousRote = '';
  if (action.oldRoute == '/' || action.oldRoute == null) return AppState(action.newRoute + previousRote);
  var newRoute = previousRote.replaceAll(action.oldRoute, action.newRoute);
  return AppState(newRoute);
}
