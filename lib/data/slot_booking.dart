
import 'package:json_annotation/json_annotation.dart';

part 'slot_booking.g.dart';

@JsonSerializable()
class SlotBooking extends Object with _$SlotBookingSerializerMixin{

  int slotId;
  String startTime;
  String endTime;

  SlotBooking(this.slotId,this.startTime,this.endTime);

  factory SlotBooking.fromJson(Map<String, dynamic> json) =>
      _$SlotBookingFromJson(json);
}