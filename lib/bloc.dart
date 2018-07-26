import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_conference/booking_widget.dart';
import 'package:flutter_conference/data/CR_model.dart';
import 'package:flutter_conference/data/booking_model.dart';
import 'package:flutter_conference/data/slot_booking.dart';
import 'package:flutter_conference/header_widget.dart';
import 'package:flutter_conference/utils/date_utils.dart';
import 'package:flutter_conference/utils/network_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Bloc {
  StreamController<DateTime> _dateController = new StreamController.broadcast();
  StreamController<List<Widget>> _listController =
      new StreamController.broadcast();
  StreamController<Map<CRModel, List<SlotBooking>>> _slotListController =
  new StreamController.broadcast();

  List<CRModel> crDataList;

  String _selectedDate;

  String username;

  String get selectedDate {
    return _selectedDate;
  }

  Stream<DateTime> get date => _dateController.stream;

  Stream<List<Widget>> get list => _listController.stream;

  Stream<Map<CRModel, List<SlotBooking>>> get slot =>
      _slotListController.stream;

  Function(DateTime) get dateSink => _dateController.sink.add;

  Function(List<Widget>) get listSink => _listController.sink.add;

  Function(Map<CRModel, List<SlotBooking>>) get slotListSink =>
      _slotListController.sink.add;

  Bloc() {
    _selectedDate = DateUtils.formatDate(DateTime.now());

    _dateController.stream.listen((date) {
      _selectedDate = DateUtils.formatDate(date);
      initData();
    });
  }

  Future initData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString("username");

    Map<String, String> map = new Map();
    map.putIfAbsent("date", () => _selectedDate);

    print(_selectedDate);
    var response = await http
        .post("https://www.reweyou.in/booking/fetchbooking.php", body: map);
    if (NetworkUtils.isReqSuccess(response: response)) {
      List<Widget> _dataList = new List();
      Map<String, dynamic> map = json.decode(response.body);
      /*   map.forEach((String room, value) {
        _dataList.add(new HeaderWidget(room));
        value.forEach((item) {
          _dataList.add(new BookingWidget(new BookingModel.fromJson(item)));
        });
      });*/

      crDataList = new List();
      List dataList = map['data'];
      dataList.forEach((item) {
        crDataList.add(CRModel.fromJson(item));
      });

      List list = map['slots'];
      List<BookingModel> _slotList = new List();
      list.forEach((item) {
        _slotList.add(new BookingModel.fromJson(item));

        /*   int crId = int.parse(room);

        crDataList.forEach((crModel) {
          if (crModel.crId == crId)
            _dataList.add(new HeaderWidget(crModel.name));
        });
        value.forEach((item) {
          _dataList.add(new BookingWidget(new BookingModel.fromJson(item)));
        });*/
      });

      if (_slotList.isNotEmpty)
        for (int i = 0; i < crDataList.length; i++) {
          for (int j = 0; j < _slotList.length; j++) {
            if (j == 0) _dataList.add(new HeaderWidget(crDataList[i].name));

            if (_slotList[j].roomId == crDataList[i].crId) {
              _dataList.add(new BookingWidget(_slotList[j], username));
            }
          }

          if (_dataList.elementAt(_dataList.length - 1) is HeaderWidget)
            _dataList.removeLast();
        }

      listSink(_dataList);
    }
  }

  Future getSlots() async {
    var response = await http.get("https://www.reweyou.in/test/test2.php");
    if (NetworkUtils.isReqSuccess(response: response)) {
      Map<CRModel, List<SlotBooking>> _dataList = new Map();
      Map<String, dynamic> map = json.decode(response.body);

      List<CRModel> roomList = new List();
      List dataList = map['data'];
      dataList.forEach((item) {
        roomList.add(CRModel.fromJson(item));
      });

      Map<String, dynamic> map1 = map['slots'];
      map1.forEach((String room, value) {
        List slotsMap = value;
        List<SlotBooking> slotList = new List();
        slotsMap.forEach((slot) {
          slotList.add(SlotBooking.fromJson(slot));
        });

        roomList.forEach(
          (item) {
            if (item.crId == int.parse(room))
              _dataList.putIfAbsent(item, () => slotList);
          },
        );

        // _dataList.add(getGridWidget(slotList));
      });

      slotListSink(_dataList);
    }
  }

  Widget getHeader(String name) {
    return new SliverList(
        delegate: new SliverChildBuilderDelegate((context, index) {
      return new Container(
        height: 40.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Conference Room: " + name,
                style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.red[900],
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    }, childCount: 1));
  }

  Future deleteBooking(int id, String slotId, int roomId, date) async {
    Map<String, String> map = new Map();
    map.putIfAbsent("id", () => id.toString());
    map.putIfAbsent("slotId", () => slotId.toString());
    map.putIfAbsent("roomId", () => roomId.toString());
    map.putIfAbsent("date", () => date.toString());

    var response = await http.post("https://www.reweyou.in/booking/deletebooking.php", body: map);
    if (NetworkUtils.isReqSuccess(response: response)) {
      initData();
    }
  }
}
