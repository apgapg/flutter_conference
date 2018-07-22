import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_conference/home_page.dart';
import 'package:flutter_conference/login_page.dart';
import 'package:flutter_conference/view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  SharedPreferences sharedPreferences;

  bool isLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FieldAssist',
        theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: isLogin == null
            ? new Container(color: Colors.white,)
            : checkLogin(),
      ),
    );
  }

  checkLogin() {
    if (isLogin) {
      return HomePage();
    } else {
      return LoginPage();
    }
  }

  Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isLogin = sharedPreferences.getBool("login") ?? false;
    });
  }
}
