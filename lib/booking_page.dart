import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_conference/bloc.dart';
import 'package:flutter_conference/booking_dialog_widget.dart';
import 'package:flutter_conference/data/CR_model.dart';
import 'package:flutter_conference/data/slot_booking.dart';
import 'package:flutter_conference/utils/network_utils.dart';
import 'package:flutter_conference/widget/header_grid_view.dart';
import 'package:http/http.dart' as http;

class BookingPage extends StatefulWidget {
  String selectedTextDate;

  BookingPage(this.selectedTextDate);

  @override
  State<StatefulWidget> createState() {
    return new MyState();
  }
}

typedef SelectSlot(int roomId);

class MyState extends State<BookingPage> {
  Bloc _bloc;

  List<CRModel> _roomlist;

  List<List<SlotBooking>> _slotlist;

  int selectedRoomIndex = 0;
  int selectedRoomId;
  String selectedRoomName;

  List<int> _selectedSlotListId = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSlots();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Available Slot"),
        actions: <Widget>[
          Builder(builder: (context) {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Icon(Icons.done),
              ),
              onTap: () {
                if (_selectedSlotListId.isEmpty)
                  Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("Please select a slot"),
                        duration: new Duration(seconds: 1),
                      ));
                else {
                  _selectedSlotListId.sort((a, b) => a.compareTo(b));
                  int tempId = _selectedSlotListId[0];

                  for (int i = 1; i < _selectedSlotListId.length; i++) {
                    if (_selectedSlotListId[i] - tempId == 1) {
                      tempId = _selectedSlotListId[i];
                    } else {
                      Scaffold.of(context).showSnackBar(
                            new SnackBar(
                                content:
                                    new Text("Slot(s) should be consecutive"),
                                duration: new Duration(seconds: 1)),
                          );
                      return;
                    }
                  }

                  String starttext;
                  String endtext;
                  for (int i = 0; i < _selectedSlotListId.length; i++) {
                    _slotlist[0].forEach((item) {
                      if (item.slotId == _selectedSlotListId[i]) {
                        if (i == 0) starttext = item.startTime;
                        if (i == _selectedSlotListId.length - 1)
                          endtext = item.endTime;
                      }
                    });
                  }

                  print(starttext + " - " + endtext);
                  showDialog(
                      context: context,
                      child: new BookingDialogWidget(
                        starttext,
                        endtext,
                        _selectedSlotListId,
                        selectedRoomId,
                          selectedRoomName,
                          widget.selectedTextDate
                      ));
                }
              },
            );
          }),
        ],
      ),
      body: new Container(
        padding: const EdgeInsets.only(top: 4.0),
        child: (_roomlist != null)
            ? Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: new Row(
                      children: getRooms(_roomlist),
                    ),
                  ),
                  Expanded(
                    child: new GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 2.5),
                      children: getChildren(),
                    ),
                  )
                ],
                /*<Widget>[

                */ /*  new SliverGrid(
                      delegate: new Sli,
                          */ /**/ /*new SliverChildBuilderDelegate((context, index) {
                        return new Container(
                          alignment: Alignment.center,
                          color: Colors.teal[100 * (index % 9)],
                          child: new Text('grid item $index'),
                        );
                      }, childCount: 20),*/ /**/ /*

                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3))*/ /*
                ],*/
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  List<Widget> getRooms(List<CRModel> roomlist) {
    List<Widget> _list = new List();
    selectedRoomId = roomlist[selectedRoomIndex].crId;
    selectedRoomName = roomlist[selectedRoomIndex].name;
    roomlist.forEach((model) {
      _list.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
            onTap: () {
              setState(() {
                selectedRoomIndex = roomlist.indexOf(model);
                selectedRoomId = model.crId;
                selectedRoomName = model.name;
                _selectedSlotListId.clear();
                return;
              });
            },
            child: Chip(
              label: new Text(model.name),
              backgroundColor: selectedRoomIndex == roomlist.indexOf(model)
                  ? Colors.blue[200]
                  : Colors.grey[400],
            )),
      ));
    });


    return _list;
  }

  getChildren() {
    return _slotlist.elementAt(selectedRoomIndex).map((slot) {
      return new HeaderGridView(slot, onSlotSelect);
    }).toList();
  }

  onSlotSelect(int slotId) {
    print(slotId);
    if (_selectedSlotListId.contains(slotId))
      _selectedSlotListId.remove(slotId);
    else
      _selectedSlotListId.add(slotId);
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

      setState(() {
        _roomlist = _dataList.keys.toList();
        _slotlist = _dataList.values.toList();
      });

      // slotListSink(_dataList);
    }
  }
}
