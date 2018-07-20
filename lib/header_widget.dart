import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String room;

  HeaderWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 32.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Conference Room: "+room,
              style: new TextStyle(
                  fontSize: 16.0, color: Colors.red[900], fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
