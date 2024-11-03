import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/contact_entity.dart';

abstract interface class ContactRepository {
  Future<Either<Failure, Contact>> addContact({required String name, required String phone});
  Future<Either<Failure, bool>> deleteContact({required int id});
  Future<Either<Failure, Contact>> updateContact({required int id, required String name, required String phone});
  Future<Either<Failure,List<Contact>>> getContacts();
}
