enum CacheErrorType {
  write,
  read,
  delete,
  notFound;

  String get message => switch(this) {
    write => 'Error writing to cache',
    read => 'Error reading from cache',
    delete => 'Error deleting from cache',
    notFound => 'Data not found in cache'
  };
}

class CacheException implements Exception {
  final String message;
  final CacheErrorType type;

  CacheException({
    required this.type,
    String? message,
  }) : message = message ?? type.message;

  @override
  String toString() => 'CacheException(${type.name}): $message';
}
