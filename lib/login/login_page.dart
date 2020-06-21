import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../signup/signup_page.dart';
import '../home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  login(String email, String password) async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if (user.uid != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', user.uid);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => Contacts()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 30, top: 60, right: 30, bottom: 10),
        child: Form(
          key: _formKey,
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
              TextFormField(
                validator: (String value) {
                  if (value.length == 0) return 'Please enter the email.';
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellowAccent[700])),
                  labelText: 'Enter Email',
                  labelStyle: TextStyle(color: Colors.yellowAccent[700]),
                ),
                cursorColor: Colors.yellowAccent[700],
                style: TextStyle(color: Colors.yellowAccent[700]),
                onSaved: (String value) {
                    email = value.trim();
                },
              ),
              TextFormField(
                validator: (String value) {
                  if (value.length == 0) return 'Please enter the password.';
                },
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.yellowAccent[700])),
                    labelText: 'Enter Password',
                    labelStyle: TextStyle(color: Colors.yellowAccent[700])),
                obscureText: true,
                style: TextStyle(color: Colors.yellowAccent[700]),
                cursorColor: Colors.yellowAccent[700],
                onSaved: (String value) {
                    password = value;
                },
              ),
              RaisedButton(
                child: Text('Login'),
                onPressed: () {
                  login(email, password);
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
      ),
    );
  }
}
