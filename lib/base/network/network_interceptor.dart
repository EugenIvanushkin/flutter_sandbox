import 'package:flutter_sample/base/network/environment.dart';
import 'package:http_middleware/http_middleware.dart';

class NetworkInterceptor implements MiddlewareContract {
  @override
  void interceptRequest({RequestData data}) {
    switch (NetworkDestinationExtension.fromBaseURL(data.url)) {
      case NetworkDestination.test:
        // TODO: Add auth logic
        break;
    }
  }

  @override
  void interceptResponse({ResponseData data}) {}
}