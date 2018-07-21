// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotBooking _$SlotBookingFromJson(Map<String, dynamic> json) {
  return new SlotBooking(json['slotId'] as int, json['startTime'] as String,
      json['endTime'] as String);
}

abstract class _$SlotBookingSerializerMixin {
  int get slotId;
  String get startTime;
  String get endTime;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'slotId': slotId,
        'startTime': startTime,
        'endTime': endTime
      };
}
