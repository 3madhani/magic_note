class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class ValidationException implements Exception {
  final String message;
  const ValidationException(this.message);
}
