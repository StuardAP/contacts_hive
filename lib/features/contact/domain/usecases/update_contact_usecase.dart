import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/contact_entity.dart';
import '../repositories/contact_repository.dart';

class UpdateContactUseCase implements UseCase<Contact, UpdateParams> {
  final ContactRepository repository;

  UpdateContactUseCase({required this.repository});

  @override
  Future<Either<Failure, Contact>> call(UpdateParams params) async {
    return await repository.updateContact(id: params.id, name: params.name, phone: params.phone);
  }
}

class UpdateParams extends Equatable {
  final int id;
  final String name;
  final String phone;
  const UpdateParams({required this.id,required this.name, required this.phone});

  @override
  List<Object> get props => [id, name , phone];
}

