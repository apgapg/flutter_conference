import 'package:json_annotation/json_annotation.dart';

part 'filled_model.g.dart';

@JsonSerializable()
class FilledModel extends Object with _$FilledModelSerializerMixin {
  int roomId;
  String slot;

  FilledModel(this.roomId, this.slot);

  factory FilledModel.fromJson(Map<String, dynamic> json) => _$FilledModelFromJson(json);
}
