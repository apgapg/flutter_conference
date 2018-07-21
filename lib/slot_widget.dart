import 'package:flutter/material.dart';
import 'package:flutter_conference/data/slot_booking.dart';

class SlotWidget extends StatefulWidget {
  SlotBooking slotBooking;

  SlotWidget(this.slotBooking);

  @override
  State<StatefulWidget> createState() {
    return new MyState();
  }
}

class MyState extends State<SlotWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(6.0),
      color: Colors.grey,
      alignment: Alignment.center,
      child: new Text(
        widget.slotBooking.startTime + " - " + widget.slotBooking.endTime,
      ),
    );
  }
}
