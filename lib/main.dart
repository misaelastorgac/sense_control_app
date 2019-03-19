import 'package:flutter/material.dart';
import 'package:flutter_login_demo/pages/authentication.dart';
import 'package:flutter_login_demo/pages/root_page.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Login',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new RootPage(auth: new Auth())

    );
  }


  
}