// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) {
  return new BookingModel(
      json['id'] as int,
      json['slot'] as String,
      json['name'] as String,
      json['userId'] as int,
      json['description'] as String,
      json['roomId'] as int,
      json['uid'] as int);
}

abstract class _$BookingModelSerializerMixin {
  String get slot;
  String get name;
  int get userId;
  String get description;
  int get id;

  int get uid;

  int get roomId;
  Map<String, dynamic> toJson() => <String, dynamic>{
    'slot': slot,
        'name': name,
        'userId': userId,
        'description': description,
        'id': id,
    'uid': uid,
    'roomId': roomId
      };
}
