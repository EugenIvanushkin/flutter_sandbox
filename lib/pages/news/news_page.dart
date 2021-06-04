import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample/base/page/base_redux_page.dart';
import 'package:flutter_sample/base/utils/dispose.dart';
import 'package:flutter_sample/pages/news/redux/action.dart';
import 'package:flutter_sample/pages/news/redux/state.dart';
import 'package:flutter_sample/pages/news/redux/store.dart';
import 'package:flutter_sample/style/dimens.dart';
import 'package:redux/redux.dart';

import 'models/user_model.dart';

class _Dimens {
  static const IMAGE_SIZE = 48.0;
  static const IMAGE_CORNER = 25.0;
}

class NewsPage extends BaseReduxPage<NewsPageState, NewsVM> {
  @override
  NewsPageS createState() => NewsPageS();
}

class NewsPageS extends BaseReduxPageState<NewsPage, NewsPageState, NewsVM> {
  @override
  createStore() => NewsStoreCreator().createReduxStore();

  @override
  Widget progressIndicator() => Center(
        child: CircularProgressIndicator(),
      );

  @override
  NewsVM storeToVM(BuildContext context, Store<NewsPageState> store) {
    viewModel = NewsVM(store, onError: (err) {
      // TODO: add support handling error in 'showError'
      showError();
    });
    return viewModel;
  }

  Widget _buildCard(UserModel userModel) {
    return Card(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(Dimens.ROW_MARGIN_SMALL),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_Dimens.IMAGE_CORNER),
              child: Image.network(
                userModel.picture.thumbnailUrl,
                height: _Dimens.IMAGE_SIZE,
                width: _Dimens.IMAGE_SIZE,
              ),
            ),
          ),
          SizedBox(
            width: Dimens.SPACE_NORMAL,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userModel.name.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(userModel.email)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
        itemCount: viewModel.items.length,
        itemBuilder: (BuildContext context, int index) {
          viewModel.checkLoadMore(index);
          return _buildCard(viewModel.items[index]);
        });
  }

  @override
  Widget buildPage(BuildContext context, NewsVM viewModel) {
    return Scaffold(
        appBar: AppBar(
          title: Text("texts.titlePageNews"),
        ),
        body: RefreshIndicator(
          child: _buildList(context),
          onRefresh: () => viewModel.refreshHandler(),
        ));
  }
}

class NewsVM with DisposeBag {
  final Store<NewsPageState> _store;
  final Function(Exception) onError;
  StreamSubscription _reloadSubscription;

  List<UserModel> get items {
    return _store.state.items;
  }

  NewsVM(this._store, {this.onError}) {
    if (!this._store.state.isFirstLoaded && !this._store.state.isLoading) {
      reload();
    }
    _store.onChange.listen((event) {
      if (event.loadError == null) return;
      _store.dispatch(LoadErrorAction(null));
      onError(event.loadError);
    }).disposeBag(bag);
  }

  Future<void> refreshHandler() {
    var completer = Completer();
    _reloadSubscription = _store.onChange.listen((event) {
      if (!event.isLoading) {
        _reloadSubscription.cancel();
        completer.complete();
      }
    }).disposeBag(bag);
    reload();
    return completer.future;
  }

  bool checkLoadMore(int index) {
    if (!_store.state.needLoadMore(index)) return false;
    load();
    return true;
  }

  void reload() {
    _store.dispatch(ReloadAction());
  }

  void load() {
    _store.dispatch(LoadAction());
  }
}
