import 'package:contacts_hive/models/contact_model.dart';
import 'package:contacts_hive/pages/contact_form.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
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
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: _buildListView()),
            const ContactForm()
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ValueListenableBuilder(
        valueListenable: Hive.box('contacts').listenable(),
        builder: (context, Box contactBox, _) {
          return ListView.builder(
            itemCount: contactBox.length,
            itemBuilder: (BuildContext context, int index) {
              final contact = contactBox.getAt(index) as ContactModel;
              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.phone),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        contactBox.deleteAt(index);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        contactBox.putAt(
                          index,
                          ContactModel(
                              name: 'Updated Name', phone: 'Updated Phone'),
                        );
                      },
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
