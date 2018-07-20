// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) {
  return new BookingModel(
      json['id'] as int,
      json['startTime'] as int,
      json['endTime'] as int,
      json['name'] as String,
      json['userId'] as int,
      json['description'] as String);
}

abstract class _$BookingModelSerializerMixin {
  int get startTime;
  int get endTime;
  String get name;
  int get userId;
  String get description;
  int get id;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'startTime': startTime,
        'endTime': endTime,
        'name': name,
        'userId': userId,
        'description': description,
        'id': id
      };
}
