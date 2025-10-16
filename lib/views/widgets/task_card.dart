import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task_category.dart';
import 'package:to_do/views/tasks_details_view.dart';

class TaskCard extends StatelessWidget {
  final TaskCategory category;
  TaskCard({
    super.key,
    required this.category,
  });
  final TaskController taskcontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    IconData catIcon = IconData(category.iconCode, fontFamily: 'MaterialIcons');
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Get.to(() => TasksDetailsView(taskcategory: category));
      },
      child: GetBuilder<TaskController>(builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: StepProgressIndicator(
                    totalSteps:
                        controller.allCreatedTasksInCategory(category) == 0
                            ? 1
                            : controller.allCreatedTasksInCategory(category),
                    currentStep: controller.completedTasksInCategory(category),
                    size: 3,
                    padding: 0,
                    unselectedGradientColor: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white, Colors.white]),
                    selectedGradientColor: LinearGradient(
                      colors: [
                        Color(category.colorValue).withOpacity(0.5),
                        Color(category.colorValue)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Icon(
                  catIcon,
                  color: Color(category.colorValue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 30),
                child: Column(
                  children: [
                    Text(
                      category.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      "${controller.uncompletedTasksInCategory(category)} Tasks",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
