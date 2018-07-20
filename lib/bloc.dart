import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_conference/booking_widget.dart';
import 'package:flutter_conference/data/booking_model.dart';
import 'package:flutter_conference/header_widget.dart';
import 'package:flutter_conference/utils/network_utils.dart';
import 'package:http/http.dart' as http;

class Bloc {


  StreamController<DateTime> _dateController = new StreamController.broadcast();
  StreamController<List<Widget>> _listController =
      new StreamController.broadcast();

  Stream<DateTime> get date => _dateController.stream;

  Stream<List<Widget>> get list => _listController.stream;

  Function(DateTime) get dateSink => _dateController.sink.add;

  Function(List<Widget>) get listSink => _listController.sink.add;

  Bloc(){
    _dateController.stream.listen((date){
      initData();
    });
  }

  Future initData() async {
    var response = await http.get("https://www.reweyou.in/test/test1.php");
    if (NetworkUtils.isReqSuccess(response: response)) {
      List<Widget> _dataList = new List();
      Map<String, dynamic> map = json.decode(response.body);
      map.forEach((String room, value) {
        _dataList.add(new HeaderWidget(room));
        value.forEach((item) {
          _dataList.add(new BookingWidget(new BookingModel.fromJson(item)));
        });
      });

      listSink(_dataList);
    }
  }
}
