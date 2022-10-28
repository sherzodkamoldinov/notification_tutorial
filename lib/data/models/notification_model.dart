import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(defaultValue: '', name: 'title')
  String title;

  @JsonKey(defaultValue: '', name: 'desc')
  String desc;

  @JsonKey(defaultValue: '', name: 'todo_type')
  String todoType;

  @JsonKey(defaultValue: '', name: 'created_at')
  String createdAt;



  NotificationModel({
    required this.title,
    required this.desc,
    required this.todoType,
    required this.createdAt,

  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
