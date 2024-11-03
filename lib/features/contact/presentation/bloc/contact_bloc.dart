import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/contact_model.dart';
import '../../domain/entities/contact_entity.dart';
import '../../domain/usecases/add_contact_usecase.dart';
import '../../domain/usecases/delete_contact_usecase.dart';
import '../../domain/usecases/get_contacts.dart';
import '../../domain/usecases/update_contact_usecase.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final AddContactUsecase _addContactUsecase;
  final GetContactsUseCase _getContactsUsecase;
  final DeleteContactUseCase _deleteContactUsecase;
  final UpdateContactUseCase _updateContactUsecase;

  ContactBloc({
    required AddContactUsecase addContact,
    required GetContactsUseCase getContacts,
    required DeleteContactUseCase deleteContact,
    required UpdateContactUseCase updateContact,
  })  : _addContactUsecase = addContact,
        _getContactsUsecase = getContacts,
        _deleteContactUsecase = deleteContact,
        _updateContactUsecase = updateContact,
        super(ContactInitial()) {
    on<AddContact>(_onAddContact);
    on<FetchContacts>(_onFetchAllContacts);
    on<DeleteContact>(_onDeleteContact);
    on<UpdateContact>(_onUpdateContact);
  }

  Future<void> _onAddContact(
      AddContact event, Emitter<ContactState> emit) async {
    final result = await _addContactUsecase(
        ContactParams(name: event.name, phone: event.phone));

    result.fold(
      (failure) =>
          emit(ContactError('Error adding contact: ${failure.message}')),
      (newContact) {
        if (state is ContactLoaded) {
          final currentContacts = (state as ContactLoaded).contacts;
          emit(ContactLoaded(List.from(currentContacts)..add(newContact)));
        } else {
          emit(ContactLoaded([newContact]));
        }
      },
    );
  }

  Future<void> _onDeleteContact(
      DeleteContact event, Emitter<ContactState> emit) async {
    if (state is ContactLoaded) {
      final currentContacts = (state as ContactLoaded).contacts;

      final result = await _deleteContactUsecase(DeleteParams(id: event.id));

      result.fold(
        (failure) =>
            emit(ContactError('Error deleting contact: ${failure.message}')),
        (_) {
          final updatedContacts = List<ContactModel>.from(currentContacts)
            ..removeWhere((c) => c.id == event.id);
          emit(ContactLoaded(updatedContacts));
        },
      );
    } else {
      add(const FetchContacts());
    }
  }

  Future<void> _onUpdateContact(
      UpdateContact event, Emitter<ContactState> emit) async {
    emit(ContactLoading());
    final result = await _updateContactUsecase(
      UpdateParams(id: event.id, name: event.name, phone: event.phone),
    );
    result.fold(
      (failure) =>
          emit(ContactError('Error updating contact: ${failure.message}')),
      (_) => add(const FetchContacts()), // Refetch contacts after updating
    );
  }

  Future<void> _onFetchAllContacts(
      FetchContacts event, Emitter<ContactState> emit) async {
    emit(ContactLoading());
    final result = await _getContactsUsecase();

    result.fold(
      (failure) => emit(ContactError(failure.message)),
      (contacts) {
        emit(ContactLoaded(contacts.isEmpty ? [] : contacts));
      },
    );
  }
}
