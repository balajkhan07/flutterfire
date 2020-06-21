import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_firebase_chat/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          Column(
            children: contacts
                .elementAt(index)
                .phones
                .map((f) => Text(f.value))
                .toList(),
          )
          //_buildPhones(context, index)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text('Menu'),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final result = await prefs.remove('uid');
                  if (result) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyApp()));
                  }
                },
                title: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contacts'),
      ),
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
