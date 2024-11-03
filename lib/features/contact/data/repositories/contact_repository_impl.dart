import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/contact_entity.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/local/contact_local_datasource.dart';
import '../models/contact_model.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactLocalDataSource localDataSource;

  ContactRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Contact>> addContact({
    required String name,
    required String phone,
  }) async {
    try {
      final result = await localDataSource.addContact(ContactModel(name: name, phone: phone));
      return Right(result);
    } catch (e) {
      return const Left(CacheWriteFailure(message: 'ERROR ADDING CONTACT'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteContact({required int id}) async {
    try {
      final contactToDelete = ContactModel(id: id, name: '', phone: '');
      final result = await localDataSource.deleteContact(contactToDelete);
      return Right(result);
    } catch (e) {
      return const Left(CacheDeleteFailure(message: 'ERROR DELETING CONTACT'));
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> getContacts() async {
    try {
      final result = await localDataSource.getContacts();
      return Right(result);
    } catch (e) {
      return const Left(CacheReadFailure(message: 'ERROR GETTING CONTACTS'));
    }
  }

  @override
  Future<Either<Failure, Contact>> updateContact({
    required int id,
    required String name,
    required String phone,
  }) async {
    try {
      final updatedContact = ContactModel(id: id, name: name, phone: phone);
      final result = await localDataSource.updateContact(updatedContact);
      return Right(result as Contact);
    } catch (e) {
      return const Left(CacheWriteFailure(message: 'ERROR UPDATING CONTACT'));
    }
  }
}
