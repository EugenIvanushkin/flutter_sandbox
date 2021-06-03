import 'package:flutter_sample/base/auth/auth_constants.dart';
import 'package:flutter_sample/base/network/environment.dart';
import 'package:flutter_sample/base/network/network_route.dart';
import 'package:http_middleware/http_methods.dart';

class ApiRoutes {
  static NetworkRoute getAuthSecret(String state, String timestamp) =>
      NetworkRoute(NetworkDestination.esia, Method.GET,
          'esia-rs/api/internal/v1/security/client-secret', {
        "scope": AuthConstants.scope,
        "timestamp": timestamp,
        "clientId": AuthConstants.clientIdentifier,
        "state": state
      });

  static NetworkRoute getRandomUsers({int page, int pageSize}) {
    return NetworkRoute(NetworkDestination.test, Method.GET, '',
        {"page": page, "results": pageSize, "seed": "abc"});
  }
}
