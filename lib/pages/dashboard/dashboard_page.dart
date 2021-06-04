import 'package:flutter/material.dart';
import 'package:flutter_sample/base/navigation/navigation.dart';
import 'package:flutter_sample/base/page/base_redux_page.dart';
import 'package:flutter_sample/base/page/logout_mixin.dart';
import 'package:flutter_sample/pages/dashboard/redux/state.dart';
import 'package:flutter_sample/pages/dashboard/redux/store.dart';
import 'package:flutter_sample/style/dimens.dart';
import 'package:redux/redux.dart';

class DashboardPage extends BaseReduxPage<DashboardPageState, DashboardVM> {
  @override
  DashboardPageS createState() => DashboardPageS();
}

class DashboardPageS
    extends BaseReduxPageState<DashboardPage, DashboardPageState, DashboardVM>
    with LogoutMixin {
  @override
  createStore() => DashboardStoreCreator().createReduxStore();

  @override
  Widget progressIndicator() => Center(
        child: CircularProgressIndicator(),
      );

  @override
  DashboardVM storeToVM(BuildContext context, Store<DashboardPageState> store) {
    viewModel = DashboardVM.build();
    return viewModel;
  }

  @override
  Widget buildPage(BuildContext context, DashboardVM viewModel) {
    return Scaffold(
        appBar: AppBar(
          title: Text("texts.titlePageDashboard"),
          actions: [
            FlatButton(
              onPressed: () => showLogoutDialog(),
              child: Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Container(
            alignment: const Alignment(0.0, -1.0),
            padding: const EdgeInsets.fromLTRB(
                Dimens.SPACE_NORMAL, Dimens.SPACE_BIG, Dimens.SPACE_NORMAL, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, NEWS),
                    child: Text("texts.titlePageNews"))
              ],
            ),
          ),
        ));
  }
}

class DashboardVM {
  DashboardVM();

  static DashboardVM build() {
    return DashboardVM();
  }
}
