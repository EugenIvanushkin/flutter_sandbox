import 'package:flutter/material.dart';
import 'package:flutter_sample/base/app/redux_app.dart';

import 'base_redux_page.dart';

mixin LogoutMixin<Page extends BaseReduxPage, ReduxState, VM>
    on BaseReduxPageState<Page, ReduxState, VM> {
  showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(texts.logoutAlertTitle),
        content: Text(texts.logoutAlertMessage),
        actions: [
          ElevatedButton(
            child: Text(texts.logoutAlertNo),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.red),
            onPressed: () async {
              Navigator.of(context).pop();
              FlutterReduxApp.navigatorKey.currentState
                  .pushNamedAndRemoveUntil("/", (_) => false);
            },
            child: Text(texts.logoutAlertYes),
          ),
        ],
      ),
    );
  }
}
