import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel extends Object with _$BookingModelSerializerMixin {
  int startTime;
  int endTime;
  String name;
  int userId;
  String description;
  int id;
  int crId;

  BookingModel(this.id, this.startTime, this.endTime, this.name, this.userId,
      this.description,this.crId);

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
}

