import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../signup/signup_page.dart';
/* import 'package:shared_preferences/shared_preferences.dart'; */

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String email;
  String password;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void login(String email, String password) async {
    FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    /* SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('uid', user.uid);

    print(prefs.getString('uid')); */

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text(user.uid),
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
    );
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
              child: Text('Login'),
              onPressed: () {
                setState(() {
                  login(email, password);
                });
              },
              textColor: Colors.white,
              color: Colors.yellowAccent[700],
            ),
            Center(
              child: InkWell(
                child: Text('Dont have an account? Register here!'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SignupPage()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
