import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/task_category.dart';
import '../models/task_item.dart';

class TaskController extends GetxController {
  TaskCategory? selectedCategory;
  String catname = '';
  int icondata = 0;
  int color = 0;
  RxInt selectedIndex = (-1).obs;
  RxInt selectedIconCode = 0.obs;
  var categories = <TaskCategory>[].obs;
  late Box<TaskCategory> categoryBox;

  @override
  void onInit() {
    super.onInit();
    categoryBox = Hive.box<TaskCategory>('categories');
    loadCategories();
  }

  void loadCategories() {
    categories.assignAll(categoryBox.values.toList());
  }

  void addCategory(String name, int iconCode, int colorValue) {
    final newCategory =
        TaskCategory(name: name, iconCode: iconCode, colorValue: colorValue);
    categoryBox.add(newCategory);
    loadCategories();
    update();
  }

  void addTask(TaskCategory category, String title) {
    final updatedTasks = List<TaskItem>.from(category.tasks);
    final newTask = TaskItem(title: title);
    updatedTasks.add(newTask);
    category.tasks = updatedTasks;
    category.save();
    update();
  }

  void toggleTaskCompletion(TaskCategory category, TaskItem task) {
    final updatedTasks = List<TaskItem>.from(category.tasks);
    final taskIndex = updatedTasks.indexOf(task);
    if (taskIndex != -1) {
      updatedTasks[taskIndex].isCompleted =
          !updatedTasks[taskIndex].isCompleted;
      category.tasks = updatedTasks;
      category.save();
      update();
    }
  }

  // void deleteTask(TaskCategory category, int index) {
  //   category.tasks.removeAt(index);
  //   category.save();
  //   loadCategories();
  //   update();
  // }
  void deleteTaskByItem(TaskCategory category, TaskItem task) {
  final updatedTasks = List<TaskItem>.from(category.tasks);
  updatedTasks.remove(task);
  category.tasks = updatedTasks;
  category.save();
  loadCategories();
  update();
}

  void deleteCategory(TaskCategory category) async {
    await category.delete(); // Deletes from Hive
    loadCategories();
    update(); // Refresh observable list
  }

  void selectCategory({required TaskCategory taskcategory}) {
    selectedCategory = taskcategory;
    update();
  }

  int completedTasksInCategory(TaskCategory category) {
    return category.tasks.where((task) => task.isCompleted).length;
  }

  int uncompletedTasksInCategory(TaskCategory category) {
    return category.tasks.where((task) => !task.isCompleted).length;
  }

  int allCreatedTasksInCategory(TaskCategory category) =>
      (completedTasksInCategory(category) +
          uncompletedTasksInCategory(category));

  List<TaskItem> unCompletedTasksList(TaskCategory category) =>
      category.tasks.where((t) => !t.isCompleted).toList();
  List<TaskItem> completedTasksList(TaskCategory category) =>
      category.tasks.where((t) => t.isCompleted).toList();

  int get totalCompletedTasks {
    int count = 0;
    for (var category in categories) {
      count += category.tasks.where((task) => task.isCompleted).length;
    }
    return count;
  }

  int get totalUncompletedTasks {
    int count = 0;
    for (var category in categories) {
      count += category.tasks.where((task) => !task.isCompleted).length;
    }
    return count;
  }

  int get totalCreatedTasks {
    int count = 0;
    for (var category in categories) {
      count += category.tasks.length;
    }
    return count;
  }

  int get efficiency {
    final total = totalCreatedTasks;
    if (total == 0) return 0;
    return ((totalCompletedTasks / total) * 100).round();
  }

  
}
