import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_conference/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyState();
  }
}

class MyState extends State<LoginPage> {
  bool _buttonEnabled = false;

  String _text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage('assets/images/logo.png')),
              ),
              height: 80.0,
              width: 80.0,
              margin: const EdgeInsets.only(bottom: 16.0),
            ),
            Container(
              width: 200.0,
              child: new Text(
                "Welcome to Conference Room Booking",
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 250.0,
              padding: const EdgeInsets.all(28.0),
              child: new TextField(
                onChanged: (text) {
                  _text = text;
                  setState(() {
                    if (text.trim().length > 0)
                      _buttonEnabled = true;
                    else
                      _buttonEnabled = false;
                  });
                },
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(16.0),
                    labelText: "Your Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: new RaisedButton(
                onPressed: _buttonEnabled
                    ? () {
                        onSubmit();
                      }
                    : null,
                color: Colors.white,
                child: new Text(
                  "SUBMIT",
                  style: new TextStyle(
                      color: _buttonEnabled ? Colors.blue : Colors.grey[700]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future onSubmit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setBool("login", true);
    sharedPreferences.setString("username", _text);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
