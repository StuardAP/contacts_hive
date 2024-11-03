import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/contact_repository.dart';

class DeleteContactUseCase implements UseCase<bool, DeleteParams> {
  final ContactRepository repository;

  DeleteContactUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(DeleteParams params) async {
    return await repository.deleteContact(
      id: params.id,
    );
  }
}

class DeleteParams extends Equatable {
  final int id;
  const DeleteParams({required this.id});

  @override
  List<Object> get props => [id];
}
