import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task_category.dart';

class SwipeCompleteTask extends StatelessWidget {
  final Widget child;
  final TaskCategory taskcategory;
  final int index;
  final TaskController taskcontroller;

  const SwipeCompleteTask(
      {super.key,
      required this.child,
      required this.taskcategory,
      required this.index,
      required this.taskcontroller});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key("task"),
      background: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 20,
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Swipe left to delete
          final confirmed = await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Delete!'),
              content: Text('Are you sure you want to delete this task?'),
              actions: [
                TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      //to do
                      taskcontroller.deleteTask(taskcategory, index);
                      Get.back();
                    },
                    child: Text('Delete')),
              ],
            ),
          );
          return confirmed;
        } else {
          return null;
        }
      },
      onDismissed: (direction) {
        // Handle deletion
      },
      child: child,
    );
  }
}
