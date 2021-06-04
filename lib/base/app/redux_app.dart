import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample/base/app/redux/action.dart';
import 'package:redux/redux.dart';
import 'package:flutter_sample/base/app/redux/state.dart';

abstract class FlutterReduxApp extends StatelessWidget {
  final Store<AppState> store;

  FlutterReduxApp(this.store);

  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  static String refreshRoute = '';

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: StoreConnector<AppState, AppVM>(
            converter: (store) => AppVM.build(store),
            builder: (context, viewModel) {
              return buildApp(viewModel);
            }));
  }

  Widget buildApp(AppVM viewModel) {
    var routes = getRoutes(viewModel);
    // TODO add common screens to routes
    return MaterialApp(
      title: 'SampleApp',
      navigatorObservers: <NavigatorObserver>[
        VRRouteObserver(
          viewModel.onPush,
          viewModel.onPop,
          viewModel.onRemove,
          viewModel.onReplace,
        ),
      ],
      // TODO add theme
      navigatorKey: navigatorKey,
      routes: routes
    );
  }

  Map<String, WidgetBuilder> getRoutes(AppVM viewModel);
}

class AppVM {
  final routeToRestore;
  final Function(String) onPush;
  final Function() onPop;
  final Function(String) onRemove;
  final Function(String, String) onReplace;

  AppVM({
    this.routeToRestore,
    this.onPush,
    this.onPop,
    this.onRemove,
    this.onReplace,
  });

  static AppVM build(Store<AppState> store) {
    return AppVM(
      routeToRestore: store.state.route,
      onPush: (route) => store.dispatch(PushRouteAction(route)),
      onPop: () => store.dispatch(PopRouteAction()),
      onRemove: (route) => store.dispatch(RemoveRouteAction(route)),
      onReplace: (oldRoute, newRoute) =>
          store.dispatch(ReplaceRouteAction(oldRoute, newRoute)),
    );
  }
}

class VRRouteObserver extends RouteObserver {
  final Function(String) onPush;
  final Function() onPop;
  final Function(String) onRemove;
  final Function(String, String) onReplace;

  VRRouteObserver(this.onPush, this.onPop, this.onRemove, this.onReplace);

  @override
  void didPop(Route route, Route previousRoute) {
    onPop();
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route previousRoute) {
    onPush(route.settings.name); // note : take new route name that just pushed
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    onRemove(route.settings.name);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    onReplace(oldRoute.settings.name, newRoute.settings.name);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
