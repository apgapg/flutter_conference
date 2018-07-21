import 'package:flutter/material.dart';
import 'package:flutter_conference/booking_page.dart';
import 'package:flutter_conference/data/slot_booking.dart';

class HeaderGridView extends StatefulWidget {
  SlotBooking slotList;
  bool selected = false;
  bool booked = false;

  SelectSlot onSlotSelect;

  HeaderGridView(this.slotList, this.onSlotSelect);

  @override
  HeaderGridViewState createState() {
    return new HeaderGridViewState();
  }
}

class HeaderGridViewState extends State<HeaderGridView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
      onTap: () {
        setState(() {
          if (!widget.booked) {
            widget.selected ? widget.selected = false : widget.selected = true;

            widget.onSlotSelect(widget.slotList.slotId);
          }
        });
      },
      child: Container(
          margin: const EdgeInsets.all(4.0),
          color: widget.booked
              ? Colors.transparent
              : (widget.selected ? Colors.blue[200] : Colors.grey[300]),
          alignment: Alignment.center,
          child: widget.booked
              ? Text("")
              : new Text(
                  widget.slotList.startTime + " - " + widget.slotList.endTime,
                  style: new TextStyle(fontSize: 12.0, color: Colors.black87),
                )),
    );
  }
}
