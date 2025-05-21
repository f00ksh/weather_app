// Custom exceptions for better error handling
class WeatherServiceException implements Exception {
  final String message;
  final dynamic originalError;

  WeatherServiceException(this.message, [this.originalError]);

  @override
  String toString() =>
      'WeatherServiceException: $message${originalError != null ? ' ($originalError)' : ''}';
}

class NetworkException extends WeatherServiceException {
  NetworkException(super.message, [super.originalError]);
}

class ApiException extends WeatherServiceException {
  ApiException(super.message, [super.originalError]);
}
