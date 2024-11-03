import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/contact_model.dart';
import '../bloc/contact_bloc.dart';
import '../widgets/contact_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(const FetchContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Contacts Hive'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: BlocBuilder<ContactBloc, ContactState>(
                builder: (context, state) {
                  return _mapContactStateToWidget(state);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey.shade900,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _mapContactStateToWidget(ContactState state) {
    return switch (state) {
      ContactInitial() => const Center(
          child: Text('No contacts available.'),
        ),
      ContactLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
      ContactLoaded(contacts: final contacts) => contacts.isEmpty
          ? const Center(child: Text('No contacts yet'))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final ContactModel contact = contacts[index] as ContactModel;
                return Card(
                  color: Colors.blueGrey.shade50,
                  elevation: 0,
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.blueGrey.shade900,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(contact.name),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.phone_android,
                          color: Colors.blueGrey.shade900,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(contact.phone),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit), onPressed: () => {}),
                        IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => {
                                  context.read<ContactBloc>().add(
                                        DeleteContact(id: contact.id!),
                                      )
                                }),
                      ],
                    ),
                  ),
                );
              },
            ),
      ContactError(message: final message) => Center(
          child: Text(message),
        ),
    };
  }
}

Future<void> _showFormDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'CONTACT',
          ),
        ),
        titleTextStyle: TextStyle(
          color: Colors.blueGrey.shade900,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        content: const ContactForm(),
      );
    },
  );
}
