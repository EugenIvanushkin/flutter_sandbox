import 'dart:convert';

import 'package:flutter_sample/base/app/redux/state.dart';
import 'package:flutter_sample/base/app/redux/store.dart';
import 'package:flutter_sample/base/redux/middleware.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';

class AppMiddleware extends BaseMiddleware<AppState> {
  final SharedPreferences sharedPreferences;

  AppMiddleware(this.sharedPreferences);

  @override
  saveState(Store<AppState> store) async {
    var stateString = json.encode(store.state.toJson());
    await sharedPreferences.setString(APP_STATE_KEY, stateString);
  }

  @override
  void processAction(Store<AppState> store, action) {
    // TODO: implement processAction
  }
}
