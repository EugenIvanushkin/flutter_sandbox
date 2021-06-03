class NoInternetException implements Exception {}

class BaseNetworkException implements Exception {}

class BadRequestException implements Exception {}

class NotFoundException implements Exception {
  String responseBody = "";

  NotFoundException(this.responseBody);
}

class UnauthorizedException implements Exception {}

class DeserializationException implements Exception {}