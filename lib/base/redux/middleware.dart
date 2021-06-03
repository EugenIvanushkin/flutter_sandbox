import 'dart:async';

import 'package:flutter_sample/base/utils/dispose.dart';
import 'package:redux/redux.dart';

import '../app/redux/action.dart';

abstract class BaseMiddleware<T> extends MiddlewareClass<T> with DisposeBag {
  @override
  Future call(Store<T> store, action, NextDispatcher next) async {
    if (action is ClosePageAction) {
      disposeBag();
      return;
    }
    processAction(store, action);
    next(action);
    await saveState(store);
  }

  void processAction(Store<T> store, action);

  saveState(Store<T> store);
}

extension MiddlewareStoreExtension on Store {
  void dispatchDelayed(dynamic action, {int duration = 200}) {
    Future.delayed(Duration(milliseconds: duration), () => dispatch(action));
  }
}
