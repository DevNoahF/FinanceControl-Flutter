class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic body;

  const ApiException({
    required this.message,
    this.statusCode,
    this.body,
  });

  @override
  String toString() {
    return 'ApiException($statusCode): $message';
  }
}

class NetworkException extends ApiException {
  const NetworkException(String message) : super(message: message);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    String message = 'Unauthorized',
    int? statusCode,
    dynamic body,
  }) : super(message: message, statusCode: statusCode, body: body);
}

class NotFoundException extends ApiException {
  const NotFoundException({
    String message = 'Not Found',
    int? statusCode,
    dynamic body,
  }) : super(message: message, statusCode: statusCode, body: body);
}

class CacheException extends ApiException {
  const CacheException(String message) : super(message: message);
}
