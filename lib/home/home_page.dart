import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class Contacts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactsState();
  }
}

class ContactsState extends State<Contacts> {
  Iterable<Contact> contacts = [];

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  getContacts() async {
    ContactsService.getContacts().then((c) {
      setState(() {
        contacts = c;
      });
    });
  }

  Widget _buildContacts(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(contacts.elementAt(index).displayName),
        ],
      ),
    );
  }

  /* SizedBox(
            height: contacts.elementAt(index).phones.length * 50.0,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: Column(
                        children: contacts
                            .elementAt(index)
                            .phones
                            .map((c) => Text(c.value))
                            .toList()));
              },
              itemCount: contacts.elementAt(index).phones.length,
            ),
          ) */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contacts.length > 0
          ? ListView.builder(
              itemBuilder: _buildContacts,
              itemCount: contacts.length,
            )
          : Center(
              child: new CircularProgressIndicator(),
            ),
    );
  }
}
