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
    super.message = 'Unauthorized',
    super.statusCode,
    super.body,
  });
}

class NotFoundException extends ApiException {
  const NotFoundException({
    super.message = 'Not Found',
    super.statusCode,
    super.body,
  });
}

class CacheException extends ApiException {
  const CacheException(String message) : super(message: message);
}
