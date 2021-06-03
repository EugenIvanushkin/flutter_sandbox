import 'package:flutter_sample/base/app/redux/reducer.dart';
import 'package:flutter_sample/base/app/redux/state.dart';
import 'package:flutter_sample/base/redux/store.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'middleware.dart';

const String APP_STATE_KEY = "APP_STATE";

class AppStoreCreator extends StoreCreator<AppState> {
  @override
  Future<List<Middleware<AppState>>> getMiddlewares() async =>
      [AppMiddleware(await SharedPreferences.getInstance())];

  @override
  Reducer<AppState> getReducers() => appReducers;

  @override
  Future<String> getStateString() async => Future(() {
        return "";
      });

  @override
  AppState getEmptyState() => AppState.empty();

  @override
  AppState restoreStateFromJson(Map<String, dynamic> json) =>
      AppState.restoreFromJson(json);
}
