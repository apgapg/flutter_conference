import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conference/data/booking_model.dart';
import 'package:flutter_conference/utils/date_utils.dart';

class BookingWidget extends StatelessWidget {
  final BookingModel bookingModel;

  BookingWidget(this.bookingModel);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(left: 8.0,right: 8.0,top: 4.0,bottom: 4.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 4.0),
          )
        ],
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
               getTime(),
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.group,
                    color: Colors.blue[700],
                    size: 22.0,
                  ),
                ),
                Text(
                  bookingModel.name,
                  style: new TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[700]),
                ),
              ],
            ),
          ),
          Text(
            //"For the discussion with startv and efl client. They are coming tomorrow",
            bookingModel.description,
            style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.blue[500]),
          )
        ],
      ),
    );
  }

  String getTime() {
    return DateUtils.formatTime(bookingModel.startTime)+" - "+DateUtils.formatTime(bookingModel.endTime);
  }
}
