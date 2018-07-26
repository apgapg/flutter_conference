// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filled_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilledModel _$FilledModelFromJson(Map<String, dynamic> json) {
  return new FilledModel(json['roomId'] as int, json['slot'] as String);
}

abstract class _$FilledModelSerializerMixin {
  int get roomId;

  String get slot;

  Map<String, dynamic> toJson() => <String, dynamic>{'roomId': roomId, 'slot': slot};
}
