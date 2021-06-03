import 'package:flutter_sample/base/redux/middleware.dart';
import 'package:flutter_sample/pages/dashboard/redux/state.dart';
import 'package:redux/redux.dart';

class DashboardMiddleware extends BaseMiddleware<DashboardPageState> {
  DashboardMiddleware();

  @override
  saveState(Store<DashboardPageState> store) {
    // TODO: implement saveState
  }

  @override
  void processAction(Store<DashboardPageState> store, action) {
    // TODO: implement processAction
  }
}
