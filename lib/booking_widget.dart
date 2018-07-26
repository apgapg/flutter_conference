import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conference/bloc.dart';
import 'package:flutter_conference/data/booking_model.dart';
import 'package:flutter_conference/view_model.dart';

class BookingWidget extends StatelessWidget {
  final BookingModel bookingModel;

  String username;

  BookingWidget(this.bookingModel, this.username);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(12.0),
      margin:
      const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
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
                bookingModel.slot,
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Container(
                  height: 40.0,
                  alignment: Alignment.topRight,
                  child: (username == bookingModel.name)
                      ? new IconButton(
                      padding: const EdgeInsets.all(12.0),
                      icon: new Icon(
                        Icons.delete_forever,
                        color: Colors.grey[500],
                        size: 28.0,
                      ),
                      onPressed: () {
                        showDeleteDialog(context);
                      })
                      : new Text(''),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
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
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700]),
          )
        ],
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Cancel Booking'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Are you sure you want cancel this booking?'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Yes'),
              onPressed: () async {
                Bloc bloc = Provider.of(context);
                bloc.deleteBooking(bookingModel.id, bookingModel.slotId, bookingModel.roomId, bookingModel.date);

                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
