import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_conference/bloc.dart';
import 'package:flutter_conference/booking_widget.dart';
import 'package:flutter_conference/header_widget.dart';
import 'package:flutter_conference/utils/date_utils.dart';
import 'package:flutter_conference/view_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: new MaterialApp(
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
        home: new MyHomePage(title: 'Conference Room Booking App'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Bloc _bloc;

  List<Widget> list;

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
          title: new Text(widget.title),
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
                              return Text(
                                snapshot.hasData
                                    ? DateUtils.format(snapshot.data)
                                    : "NA",
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
                      children: snapshot.hasData?snapshot.data:[new Text("")],
                    );
                  },
                  stream: _bloc.list,
                ),
              )
            ],
          ),
        )

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
}
