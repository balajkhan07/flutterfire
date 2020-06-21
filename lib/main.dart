import 'package:flutter/material.dart';
import './login/login_page.dart';
import './home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  String user;

  @override
  void initState() {
    super.initState();
    setState(() {
      checkUser();
    });
  }

  checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    user = prefs.getString('uid');
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user == null ? LoginPage() : Contacts(),
    );
  }
}
