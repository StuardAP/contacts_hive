import 'package:equatable/equatable.dart';

abstract interface class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

//* SERVER FAILURES
class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}

//* LOCAL CACHE FAILURES

class CacheWriteFailure extends Failure {
  const CacheWriteFailure({required super.message});
}

class CacheReadFailure extends Failure {
  const CacheReadFailure({required super.message});
}

class CacheDeleteFailure extends Failure {
  const CacheDeleteFailure({required super.message});
}

class CacheNotFoundFailure extends Failure {
  const CacheNotFoundFailure({required super.message});
}
