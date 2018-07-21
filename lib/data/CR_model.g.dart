// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CR_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CRModel _$CRModelFromJson(Map<String, dynamic> json) {
  return new CRModel(json['name'] as String, json['crId'] as int);
}

abstract class _$CRModelSerializerMixin {
  String get name;
  int get crId;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'name': name, 'crId': crId};
}
