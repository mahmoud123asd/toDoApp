import 'package:hive/hive.dart';
import 'task_item.dart';

part 'task_category.g.dart';

@HiveType(typeId: 0)
class TaskCategory extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int iconCode;
  @HiveField(2)
  int colorValue;
  @HiveField(3)
  List<TaskItem> tasks;

  TaskCategory({
    required this.name,
    required this.iconCode,
    required this.colorValue,
    this.tasks = const [],
  });
}
