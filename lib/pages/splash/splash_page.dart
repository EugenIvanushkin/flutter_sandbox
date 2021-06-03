import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample/base/app/redux/state.dart';
import 'package:flutter_sample/base/navigation/navigation.dart';
import 'package:uni_links/uni_links.dart';

class SplashPage<_SplashPageState> extends StatefulWidget {
  final String route;

  SplashPage(this.route);

  @override
  State<StatefulWidget> createState() => SplashPageState(route);
}

class SplashPageState extends State<SplashPage> {
  final String route;

  SplashPageState(this.route);

  @override
  void initState() {
    super.initState();
    restoreNavigation();
  }

  Future<void> restoreNavigation() async {
    if (route != null && route.isNotEmpty) {
      var success = await navigateWithRoute(route);
      if (!success) _toStart();
    } else {
      _toStart();
    }

    try {
      Uri initialUri = await getInitialUri();
      if (initialUri != null) navigateWithDeeplink(initialUri);
    } catch (e) {}
  }

  _toStart() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, DASHBOARD);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[],
            ),
          );
        });
  }
}
