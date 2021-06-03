import 'package:flutter_sample/base/redux/store.dart';
import 'package:flutter_sample/pages/dashboard/redux/reducer.dart';
import 'package:flutter_sample/pages/dashboard/redux/state.dart';
import 'package:redux/redux.dart';
import 'middleware.dart';

const String DASHBOARD_STATE_KEY = "DASHBOARD_STATE";

class DashboardStoreCreator extends StoreCreator<DashboardPageState> {
  @override
  Future<List<Middleware<DashboardPageState>>> getMiddlewares() async =>
      [DashboardMiddleware()];

  @override
  Reducer<DashboardPageState> getReducers() => dashboardReducers;

  @override
  Future<String> getStateString() async => Future((){return "";});
  @override
  DashboardPageState getEmptyState() => DashboardPageState.empty();

  @override
  DashboardPageState restoreStateFromJson(Map<String, dynamic> json) =>
      DashboardPageState.empty();
}
