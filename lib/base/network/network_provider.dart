import 'package:connectivity/connectivity.dart';
import 'package:flutter_sample/base/app/redux_app.dart';
import 'package:http/http.dart' as http;
import 'package:http_middleware/http_methods.dart';
import 'package:http_middleware/http_with_middleware.dart';

import 'network_error.dart';
import 'network_route.dart';

class NetworkProvider {
  HttpWithMiddleware _client;

  NetworkProvider() {
    this._client = HttpWithMiddleware.build(middlewares: [
    ]);
  }

  Future<String> load(NetworkRoute route) async {
    _checkConnection();
    http.Response response;
    switch (route.method) {
      case Method.GET:
        response = await _client.get(route.asURL, headers: route.headers);
        break;
      case Method.HEAD:
        throw BaseNetworkException();
        break;
      case Method.POST:
        if (route.body == null) throw BaseNetworkException();
        response = await _client.post(route.asURL,
            headers: route.headers, body: route.body);
        break;
      case Method.PUT:
        if (route.body == null) throw BaseNetworkException();
        response = await _client.put(route.asURL,
            headers: route.headers, body: route.body);
        break;
      case Method.PATCH:
        throw BaseNetworkException();
        break;
      case Method.DELETE:
        response = await _client.delete(route.asURL, headers: route.headers);
        break;
    }
    return _handleResult(response);
  }

  _checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw NoInternetException();
    }
  }

  String _handleResult(http.Response response) {
    if (response.statusCode ~/ 100 == 2) {
      return response.body;
    } else if (response.statusCode == 401) {
      if (FlutterReduxApp.refreshRoute.isNotEmpty)
        FlutterReduxApp.navigatorKey.currentState.pushNamedAndRemoveUntil(
            FlutterReduxApp.refreshRoute, (_) => false);
      throw UnauthorizedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException(response.body);
    } else if (response.statusCode ~/ 100 == 4) {
      throw BadRequestException();
    } else {
      throw BaseNetworkException();
    }
  }
}
