import 'dart:convert';

import 'package:flutter_sample/base/network/environment.dart';
import 'package:flutter_sample/base/network/network_constants.dart';
import 'package:http_middleware/http_methods.dart';

enum ContentType { json, text }

class NetworkRoute {
  final NetworkDestination destination;
  final Method method;
  final String path;
  final Map<String, dynamic> params;

  dynamic _body;
  Map<String, String> _headers = {};

  dynamic get body => _body;
  Map<String, String> get headers => _headers;

  String get asURL {
    String url = destination.getURL();
    if (params.isEmpty) return "$url$path";
    String _params = params.entries
        .map((item) =>
            "${item.key}=${Uri.encodeQueryComponent(item.value.toString())}")
        .join('&');
    return "$url$path?$_params";
  }

  NetworkRoute(this.destination, this.method, this.path, this.params);

  NetworkRoute addBody<T>(T obj) {
    _body = json.encode(obj);
    addHeader(NetworkConstants.contentTypeHeaderKey, NetworkConstants.jsonType);
    return this;
  }

  NetworkRoute addHeader(String key, String value) {
    _headers[key] = value;
    return this;
  }
}
