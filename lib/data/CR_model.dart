
import 'package:json_annotation/json_annotation.dart';

part 'CR_model.g.dart';

@JsonSerializable()
class CRModel extends Object  with _$CRModelSerializerMixin {
  String name;
  int crId;

  CRModel(this.name,this.crId);

  factory CRModel.fromJson(Map<String, dynamic> json) =>
      _$CRModelFromJson(json);

}