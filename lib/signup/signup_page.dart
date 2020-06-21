import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupPageState();
  }
}

class SignupPageState extends State<SignupPage> {
  String email;
  String password;
  String fullname;
  String username;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Firestore firestore = new Firestore();

  void signup(String email, String password) async {
    FirebaseUser user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    Object userData = {
      'email': email,
      'fullname': fullname,
      'username': username,
      'uid': user.uid
    };

    Future<DocumentReference> data =
        firestore.collection('users').add(userData);

    if (data != null) {
      Navigator.pop(context);
    }

    /* showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text(user.email),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 30, top: 60, right: 30, bottom: 10),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: SizedBox(
                child: Image.asset('assets/flutterfire.jpg'),
                height: 80,
                width: 80,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              child: Title(
                child: Text(
                  'FLUTTERFIRE',
                  style: TextStyle(
                      color: Colors.yellowAccent[700],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                color: Colors.yellowAccent[700],
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellowAccent[700])),
                labelText: 'Enter Fullname',
                labelStyle: TextStyle(color: Colors.yellowAccent[700]),
              ),
              cursorColor: Colors.yellowAccent[700],
              style: TextStyle(color: Colors.yellowAccent[700]),
              onChanged: (String value) {
                setState(() {
                  fullname = value.trim();
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellowAccent[700])),
                  labelText: 'Enter Username',
                  labelStyle: TextStyle(color: Colors.yellowAccent[700])),
              //obscureText: true,
              style: TextStyle(color: Colors.yellowAccent[700]),
              cursorColor: Colors.yellowAccent[700],
              onChanged: (String value) {
                setState(() {
                  username = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellowAccent[700])),
                labelText: 'Enter Email',
                labelStyle: TextStyle(color: Colors.yellowAccent[700]),
              ),
              cursorColor: Colors.yellowAccent[700],
              style: TextStyle(color: Colors.yellowAccent[700]),
              onChanged: (String value) {
                setState(() {
                  email = value.trim();
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellowAccent[700])),
                  labelText: 'Enter Password',
                  labelStyle: TextStyle(color: Colors.yellowAccent[700])),
              obscureText: true,
              style: TextStyle(color: Colors.yellowAccent[700]),
              cursorColor: Colors.yellowAccent[700],
              onChanged: (String value) {
                setState(() {
                  password = value;
                });
              },
            ),
            RaisedButton(
              child: Text('Signup'),
              onPressed: () {
                setState(() {
                  signup(email, password);
                });
              },
              textColor: Colors.white,
              color: Colors.yellowAccent[700],
            )
          ],
        ),
      ),
    );
  }
}
