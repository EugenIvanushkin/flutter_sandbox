import 'dart:convert';

import 'package:flutter_sample/base/platform/platform.dart';
import 'package:redux/redux.dart';

const String APP_STATE_KEY = "APP_STATE";

abstract class StoreCreator<T> {
  Future<List<Middleware<T>>> getMiddlewares();

  Reducer<T> getReducers();

  Future<String> getStateString();

  T getEmptyState();

  T restoreStateFromJson(Map<String, dynamic> json);

  Future<Store<T>> createReduxStore() async {
    bool isFirstStart = await getIsFirstStart();

    var stateString = await getStateString();
    var restoredState;
    if (isFirstStart || stateString == null) {
      restoredState = getEmptyState();
    } else {
      restoredState = restoreStateFromJson(json.decode(stateString));
    }

    return Store<T>(
      getReducers(),
      initialState: restoredState,
      middleware: await getMiddlewares(),
    );
  }
}
