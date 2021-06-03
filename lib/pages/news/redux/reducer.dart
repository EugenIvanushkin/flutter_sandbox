import 'package:flutter_sample/pages/news/redux/state.dart';

import 'action.dart';

NewsPageState newsReducers(NewsPageState state, dynamic action) {
  if (action is ProgressAction) {
    state.isLoading = action.isLoading;
  }
  if (action is ReloadAction) {
    state.resetPage();
  }
  if (action is LoadResultAction) {
    state.isFirstLoaded = true;
    state.pageLoaded(action.items, action.totalSize);
  }
  if (action is LoadErrorAction) {
    state.isFirstLoaded = true;
    state.loadError = action.error;
  }
  return state;
}
