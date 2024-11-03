
import '../../../../../core/database/hive/hive_storage_manager.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/contact_model.dart';

abstract interface class ContactLocalDataSource {
  Future<ContactModel> addContact(ContactModel contact);
  Future<bool> deleteContact(ContactModel contact);
  Future<ContactModel> updateContact(ContactModel contact);
  Future<List<ContactModel>> getContacts();
}

class ContactLocalDataSourceImpl implements ContactLocalDataSource {
  final HiveStorageManager hiveStorageManager;

  ContactLocalDataSourceImpl({required this.hiveStorageManager});

  @override
  Future<ContactModel> addContact(ContactModel contact) async {
    try {
      final box = hiveStorageManager.contactBox;
      final id = await box.add(contact.copyWith(id: box.length));
      return contact.copyWith(id: id);
    } catch (e) {
      throw CacheException(type: CacheErrorType.write);
    }
  }

  @override
  Future<bool> deleteContact(ContactModel contact) async {
    final box = hiveStorageManager.contactBox;
    try {
      if (contact.id != null && box.containsKey(contact.id)) {
        await box.delete(contact.id);
        return true;
      } else {
        throw CacheException(type: CacheErrorType.notFound);
      }
    } catch (e) {
      throw CacheException(type: CacheErrorType.delete);
    }
  }

  @override
  Future<ContactModel> updateContact(
      ContactModel contact) async {
    final box = hiveStorageManager.contactBox;
    try {
      if (contact.id != null && box.containsKey(contact.id)) {
        await box.put(contact.id, contact);
        return contact;
      } else {
        throw CacheException(type: CacheErrorType.notFound);
      }
    } catch (e) {
      throw CacheException(type: CacheErrorType.write);
    }
  }

  @override
  Future< List<ContactModel>> getContacts() async {
    final box = hiveStorageManager.contactBox;
    try {
      final contacts = box.values.whereType<ContactModel>().toList();
      return contacts;
    } catch (e) {
      throw CacheException(type: CacheErrorType.read);
    }
  }
}
