// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:to_do/controllers/task_controller.dart';
// import 'package:to_do/models/task_category.dart';

// class UncompletedTask extends StatelessWidget {
//   final TaskCategory category;
//   final TaskController controller = Get.find();
//   UncompletedTask({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//      final uncompletedTasks = category.tasks.where((t) => !t.isCompleted).toList();
//     return SizedBox(
//       height: 200,
//       child: ListView.builder(
//         itemCount: uncompletedTasks.length,
//         itemBuilder: (context, index) {
//           return Row(
//             children: [
//               GetX<TaskController>(
//                 builder: (controller) => Checkbox(
//                     value: controller.selectedIndex.value == index,
//                     onChanged: (val) {
//                       if (val!) {
//                         controller.selectedIndex.value = index;
//                         controller.toggleTaskCompletion(category,index);
//                         controller.selectedIndex.value = -1;
//                       }
//                     }),
//               ),
//               Text(uncompletedTasks[index].title),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task_category.dart';

class UncompletedTask extends StatelessWidget {
  final TaskCategory category;
  final TaskController controller = Get.find();
  UncompletedTask({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.unCompletedTasksList(category).length,
      itemBuilder: (context, index) {
        final task = controller.unCompletedTasksList(category)[index];

        return Row(
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (val) {
                controller.toggleTaskCompletion(category, task);
              },
            ),
            Text(task.title),
          ],
        );
      },
    );
  }
}
