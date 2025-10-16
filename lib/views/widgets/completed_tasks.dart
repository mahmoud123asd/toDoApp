import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task_category.dart';
import 'package:to_do/views/widgets/swipe_complete_task.dart';

class CompletedTasks extends StatelessWidget {
  final TaskCategory taskCategory;
  const CompletedTasks({super.key, required this.taskCategory});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (controller) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.completedTasksInCategory(taskCategory),
        itemBuilder: (context, index) {
          return SwipeCompleteTask(
            taskcategory: taskCategory,
            index: index,
            taskcontroller: controller,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Icon(Icons.check, color: Colors.blue, size: 28),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      controller.completedTasksList(taskCategory)[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        decoration:
                            TextDecoration.lineThrough, 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
