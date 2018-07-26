import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_conference/booking_page.dart';
import 'package:flutter_conference/data/filled_model.dart';
import 'package:flutter_conference/data/slot_booking.dart';

class HeaderGridView extends StatefulWidget {
  SlotBooking slotList;
  bool selected = false;

  SelectSlot onSlotSelect;

  List<FilledModel> filledlist;

  int selectedRoomId;

  HeaderGridView(this.slotList, this.onSlotSelect, this.filledlist, this.selectedRoomId);

  @override
  HeaderGridViewState createState() {
    return new HeaderGridViewState();
  }
}

class HeaderGridViewState extends State<HeaderGridView> {
  bool booked = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    initStatus();
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!booked) {
            widget.selected ? widget.selected = false : widget.selected = true;

            widget.onSlotSelect(widget.slotList.slotId);
          }
        });
      },
      child: Container(
          margin: const EdgeInsets.all(4.0),
          color: booked
              ? Colors.grey[200]
              : (widget.selected ? Colors.blue[200] : Colors.grey[300]),
          alignment: Alignment.center,
          child: booked
              ? Text("")
              : new Text(
            widget.slotList.startTime + " - " + widget.slotList.endTime,
            style: new TextStyle(fontSize: 12.0, color: Colors.black87),
          )),
    );
  }

  void initStatus() {
    List<int> _filledNewList = new List();
    widget.filledlist.forEach((model) {
      if (model.roomId == widget.selectedRoomId) {
        List rawlist = (json.decode(model.slot));
        rawlist.forEach((item) {
          _filledNewList.add(((item)));
        });
      }
    });

    if (_filledNewList.contains(widget.slotList.slotId)) {
      setState(() {
        booked = true;
      });
    } else
      setState(() {
        booked = false;
      });
  }
}
