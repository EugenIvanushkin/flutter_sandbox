import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample/base/app/redux/action.dart';
import 'package:flutter_sample/base/platform/platform.dart';
import 'package:flutter_sample/base/utils/dispose.dart';
import 'package:flutter_sample/l10n/app_localizations.dart';
import 'package:redux/redux.dart';

import 'base_page.dart';

abstract class BaseReduxPage<ReduxState, VM> extends BasePage {}

abstract class BaseReduxPageState<Page extends BaseReduxPage, ReduxState, VM>
    extends BasePageS<Page>
    with WidgetsBindingObserver, DisposableState, DisposeBag {
  Store<ReduxState> reduxStore;
  VM viewModel;
  AppLocalizations texts;

  createStore();

  Widget progressIndicator();

  VM storeToVM(BuildContext context, Store<ReduxState> store);

  Widget buildPage(BuildContext context, VM viewModel);

  @override
  void dispose() {
    if (viewModel is DisposeBag) {
      (viewModel as DisposeBag).disposeBag();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<Store<ReduxState>> createStoreIfNeeded() {
      if (reduxStore == null)
        return createStore();
      else
        return Future.value(reduxStore);
    }

    return FutureBuilder<Store<ReduxState>>(
      future: createStoreIfNeeded(),
      builder:
          (BuildContext context, AsyncSnapshot<Store<ReduxState>> snapshot) {
        if (!snapshot.hasData) {
          // while data is loading:
          return progressIndicator();
        } else {
          reduxStore = snapshot.data;
          dispatchCloseAction = () => reduxStore.dispatch(ClosePageAction());
          return StoreProvider<ReduxState>(
              store: reduxStore,
              child: StoreConnector<ReduxState, VM>(
                converter: (store) => storeToVM(context, store),
                builder: (context, viewModel) {
                  _updateLocalization(context);
                  return buildPage(context, viewModel);
                },
              ));
        }
      },
    );
  }

  Future<void> showError({String message, Function completion}) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message ?? texts.commonError),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (completion != null) completion();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showSettingAlert({String message}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(texts.appSettingsAlertTitle),
              content: Text(message ?? texts.appSettingsAlertMessage),
              actions: [
                TextButton(
                  child: Text(texts.appSettingsAlertNo),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton(
                  child: Text(texts.appSettingsAlertYes),
                  onPressed: () {
                    Navigator.of(context).pop();
                    openSecuritySettings();
                  },
                ),
              ],
            ));
  }

  _updateLocalization(BuildContext context) {
    texts = AppLocalizations.of(context ?? this.context);
  }
}
