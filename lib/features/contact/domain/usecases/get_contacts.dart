
import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/contact_entity.dart';
import '../repositories/contact_repository.dart';

class GetContactsUseCase implements UseCaseWithoutParams<List<Contact>> {
  final ContactRepository repository;

  GetContactsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Contact>>> call() async{
    return await repository.getContacts();
  }
}
