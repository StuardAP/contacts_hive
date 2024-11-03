import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

abstract interface class UseCaseWithoutParams<SuccessType> {
  Future<Either<Failure,SuccessType>> call();
}

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

