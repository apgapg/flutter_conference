import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_conference/utils/network_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingDialogWidget extends StatefulWidget {
  List<int> selectedSlotList;

  String starttext;
  String endtext;

  int selectedRoomId;

  String selectedRoomName;

  String selectedTextDate;

  BookingDialogWidget(this.starttext, this.endtext, this.selectedSlotList,
      this.selectedRoomId, this.selectedRoomName, this.selectedTextDate);

  @override
  State<StatefulWidget> createState() {
    return new MyState();
  }
}

class MyState extends State<BookingDialogWidget> {
  String _text;

  String _username = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
        contentPadding: const EdgeInsets.all(0.0),
        content: new SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: new Text(
                      widget.selectedRoomName,
                      style: new TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: Colors.pink[700]),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(right: 4.0),
                  ),
                  Container(
                    child: new Text(
                      widget.starttext + " - " + widget.endtext,
                      style: new TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(right: 4.0),
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.grey[400])),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: new Row(
                  children: <Widget>[
                    new Text(
                      "Name: ",
                      style: new TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      margin: const EdgeInsets.only(left: 12.0),
                      height: 32.0,
                      alignment: Alignment.center,
                      color: Colors.grey[300],
                      child: new Text(
                        _username,
                        style: new TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "Purpose: ",
                      style: new TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 12.0),
                        child: new TextField(
                          onChanged: (text) {
                            _text = text;
                          },
                          maxLines: 8,
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder()),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: new FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Text(
                              "CANCEL",
                              style: new TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600]),
                            ))),
                    new FlatButton(
                        onPressed: () {
                          if (_text.isNotEmpty)
                            uploadBooking();
                        },
                        child: new Text(
                          "BOOK",
                          style: new TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.blue),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future uploadBooking() async {
    Map<String, String> map = new Map();
    map.putIfAbsent("uid", () => _username);
    map.putIfAbsent("description", () => _text);
    map.putIfAbsent("date", () => widget.selectedTextDate);
    map.putIfAbsent("name", () => _username);
    map.putIfAbsent("slot", () => widget.starttext + " - " + widget.endtext);
    map.putIfAbsent("slotId", () => json.encode(widget.selectedSlotList));
    map.putIfAbsent("roomId", () => widget.selectedRoomId.toString());
    var response = await http
        .post("https://www.reweyou.in/booking/addbooking.php", body: map);
    if (NetworkUtils.isReqSuccess(response: response)) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      print(response.statusCode);
    }
  }

  Future getUsername() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      _username = sharedPreferences.getString("username");
    });
  }
}
