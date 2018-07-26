import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel extends Object with _$BookingModelSerializerMixin {
  String slot;
  String name;
  int userId;
  String description;
  int id;
  int uid;
  int roomId;
  String slotId;
  String date;

  BookingModel(this.id, this.slot, this.name, this.userId,
      this.description, this.roomId, this.uid, this.slotId, this.date);

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
}

