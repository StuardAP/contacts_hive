part of 'contact_bloc.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class AddContact extends ContactEvent {
  final String name;
  final String phone;

  const AddContact({required this.name, required this.phone});

  @override
  List<Object> get props => [name, phone];
}

class FetchContacts extends ContactEvent {
  const FetchContacts();
}

class DeleteContact extends ContactEvent {
  final int id;

  const DeleteContact({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateContact extends ContactEvent {
  final int id;
  final String name;
  final String phone;

  const UpdateContact(
      {required this.id, required this.name, required this.phone});

  @override
  List<Object> get props => [id, name, phone];
}
