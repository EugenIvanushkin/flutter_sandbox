import 'package:flutter_sample/base/redux/store.dart';
import 'package:flutter_sample/pages/news/redux/reducer.dart';
import 'package:flutter_sample/pages/news/redux/state.dart';
import 'package:redux/redux.dart';

import 'middleware.dart';

const String NEWS_STATE_KEY = "NEWS_STATE";

class NewsStoreCreator extends StoreCreator<NewsPageState> {
  @override
  Future<List<Middleware<NewsPageState>>> getMiddlewares() async =>
      [NewsMiddleware()];

  @override
  Reducer<NewsPageState> getReducers() => newsReducers;

  @override
  Future<String> getStateString() async => Future(() {
        return "";
      });

  @override
  NewsPageState getEmptyState() => NewsPageState.empty();

  @override
  NewsPageState restoreStateFromJson(Map<String, dynamic> json) =>
      NewsPageState.empty();
}
