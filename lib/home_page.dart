import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_conference/bloc.dart';
import 'package:flutter_conference/booking_page.dart';
import 'package:flutter_conference/utils/date_utils.dart';
import 'package:flutter_conference/view_model.dart';

class HomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  Bloc _bloc;

  List<Widget> list;

  String startTime = "StartTime";

  String _selectedTextDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*  list = new List();
    list.add(new HeaderWidget());
    list.add(new BookingWidget());
    list.add(new BookingWidget());
    list.add(new HeaderWidget());
    list.add(new BookingWidget());*/
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    _bloc = Provider.of(context);
    _bloc.initData();
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('Conference Room Booking'),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(4.0),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: new Offset(0.0, 4.0),
                      )
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.date_range,
                          size: 26.0,
                          color: Colors.blue[500],
                        ),
                      ),
                      GestureDetector(
                        child: StreamBuilder(
                          builder: (BuildContext context,
                              AsyncSnapshot<DateTime> snapshot) {
                            if (snapshot.hasData) {
                              _selectedTextDate =
                                  DateUtils.formatDate(snapshot.data);
                            }
                            return Text(
                              snapshot.hasData ? _selectedTextDate : "NA",
                              style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey[900],
                              ),
                            );
                          },
                          initialData: new DateTime.now(),
                          stream: _bloc.date,
                        ),
                        onTap: () {
                          _selectDate();
                        },
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  height: 48.0,
                )
              ],
            ),
            Expanded(
              child: new StreamBuilder(
                builder: (context, snapshot) {
                  return new ListView(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    children: snapshot.hasData ? snapshot.data : [new Text("")],
                  );
                },
                stream: _bloc.list,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          //showBookingDialog();
          showBookingPage();
        },
        child: new Container(
          height: 44.0,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(4.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: new Offset(0.0, 0.0),
              ),
            ],
          ),
          child: new Text(
            "BOOK YOUR SLOT",
            style: new TextStyle(
                color: Colors.blue[500], fontWeight: FontWeight.w700),
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future _selectDate() async {
    DateTime datetime = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().subtract(new Duration(days: 30)),
      lastDate: new DateTime.now().add(new Duration(days: 30)),
    );

    if (datetime != null) _bloc.dateSink(datetime);
  }

  void showBookingDialog() {}

  void showBookingPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingPage(_selectedTextDate)),
    );
  }
}
