import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task_category.dart';
import 'package:to_do/views/widgets/completed_tasks.dart';
import 'package:to_do/views/widgets/uncompleted_task.dart';

class TasksDetailsView extends StatelessWidget {
  final TaskCategory taskcategory;
  TasksDetailsView({super.key, required this.taskcategory});
  final TaskController taskcontroller = Get.find();
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusManager.instance.primaryFocus?.unfocus(); // hide keyboard
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          IconData(taskcategory.iconCode,
                              fontFamily: 'MaterialIcons'),
                          color: Color(taskcategory.colorValue),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          taskcategory.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: GetBuilder<TaskController>(builder: (controller) {
                      return Row(
                        children: [
                          Text(
                            "${controller.completedTasksInCategory(taskcategory)}",
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: StepProgressIndicator(
                                fallbackLength: 200,
                                totalSteps:
                                    controller.allCreatedTasksInCategory(
                                                taskcategory) ==
                                            0
                                        ? 1
                                        : controller.allCreatedTasksInCategory(
                                            taskcategory),
                                currentStep: controller
                                    .completedTasksInCategory(taskcategory),
                                size: 5,
                                padding: 0,
                                unselectedGradientColor: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Colors.grey, Colors.grey]),
                                selectedGradientColor: LinearGradient(
                                  colors: [
                                    Color(taskcategory.colorValue)
                                        .withOpacity(0.5),
                                    Color(taskcategory.colorValue)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )),
                          ),
                        ],
                      );
                    }),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 1,
                    controller: controller,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                taskcontroller.addTask(
                                    taskcategory, controller.text.trim());
                                controller.clear();
                                FocusScope.of(context).unfocus();
                              }
                            },
                            icon: Icon(
                              Icons.check,
                              color: lightBlue,
                            ))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "you must add a task";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Text(
                    "UnCompleted Tasks",
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<TaskController>(
                    builder: (controller) {
                      return UncompletedTask(category: taskcategory);
                    },
                  ),
                  Divider(
                    color: Colors.grey.shade400,
                  ),
                  Text(
                    "Completed Tasks",
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 20),
                  ),
                  CompletedTasks(
                    taskCategory: taskcategory,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
