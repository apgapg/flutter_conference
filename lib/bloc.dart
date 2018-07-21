import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_conference/booking_widget.dart';
import 'package:flutter_conference/data/CR_model.dart';
import 'package:flutter_conference/data/booking_model.dart';
import 'package:flutter_conference/data/slot_booking.dart';
import 'package:flutter_conference/header_widget.dart';
import 'package:flutter_conference/utils/network_utils.dart';
import 'package:flutter_conference/widget/header_grid_view.dart';
import 'package:http/http.dart' as http;

class Bloc {
  StreamController<DateTime> _dateController = new StreamController.broadcast();
  StreamController<List<Widget>> _listController =
      new StreamController.broadcast();
  StreamController<Map<CRModel, List<SlotBooking>>> _slotListController = new StreamController.broadcast();

  List<CRModel> crDataList;

  Stream<DateTime> get date => _dateController.stream;

  Stream<List<Widget>> get list => _listController.stream;

  Stream<Map<CRModel, List<SlotBooking>>> get slot =>
      _slotListController.stream;

  Function(DateTime) get dateSink => _dateController.sink.add;

  Function(List<Widget>) get listSink => _listController.sink.add;

  Function(Map<CRModel, List<SlotBooking>>) get slotListSink =>
      _slotListController.sink.add;

  Bloc() {
    _dateController.stream.listen((date) {
      initData();
    });
  }

  Future initData() async {
    var response = await http.get("https://www.reweyou.in/test/test1.php");
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

      Map<String, dynamic> map1 = map['slots'];
      map1.forEach((String room, value) {
        int crId = int.parse(room);

        crDataList.forEach((crModel) {
          if (crModel.crId == crId)
            _dataList.add(new HeaderWidget(crModel.name));
        });
        value.forEach((item) {
          _dataList.add(new BookingWidget(new BookingModel.fromJson(item)));
        });
      });

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
}
