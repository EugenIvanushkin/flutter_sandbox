import 'package:flutter_sample/pages/news/models/user_model.dart';

class ProgressAction {
  final bool isLoading;

  ProgressAction(this.isLoading);
}

class ReloadAction {}

class LoadAction {}

class LoadResultAction {
  final List<UserModel> items;
  final int totalSize;

  LoadResultAction(this.items, this.totalSize);
}

class LoadErrorAction {
  final Exception error;

  LoadErrorAction(this.error);
}
