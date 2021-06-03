import 'package:flutter_sample/base/page/pageable.dart';
import 'package:flutter_sample/pages/news/models/user_model.dart';

class NewsPageState extends Pageable<UserModel> {
  bool isFirstLoaded = false;
  Exception loadError;

  NewsPageState();

  NewsPageState.empty();
}
