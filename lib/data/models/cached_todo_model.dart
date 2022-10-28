import 'package:hive_flutter/hive_flutter.dart';

part 'cached_todo_model.g.dart';

@HiveType(typeId: 0)
class CachedTodoModel extends HiveObject {
  @HiveField(1)
  late String title;

  @HiveField(2)
  late String desc;

  @HiveField(3)
  late String todoType;

  @HiveField(4)
  late String createdAt;
}
