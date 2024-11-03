import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/contact_entity.dart';
import '../repositories/contact_repository.dart';

class AddContactUsecase implements UseCase<Contact, ContactParams> {
  final ContactRepository repository;

  AddContactUsecase({required this.repository});

  @override
  Future<Either<Failure, Contact>> call(ContactParams params) async {
    return await repository.addContact(name: params.name, phone: params.phone);
  }
}

class ContactParams extends Equatable {
  final String name;
  final String phone;
  const ContactParams({required this.name, required this.phone});

  @override
  List<Object> get props => [name , phone];
}
