import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/controllers/home_controller.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/views/widgets/category_list.dart';

class NewTaskView extends StatelessWidget {
  NewTaskView({super.key});
  final HomeController homecontroller = Get.find();
  final TaskController taskController = Get.find();
  TextEditingController textcontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                homecontroller.changeTab(0);
              },
              icon: Icon(Icons.clear)),
          actions: [
            InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  ///to do
                  if (formkey.currentState!.validate()) {
                    taskController.addTask(taskController.selectedCategory!,
                        textcontroller.text.trim());
                    textcontroller.clear();
                    homecontroller.changeTab(0);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: lightBlue, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: formkey,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Task",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    TextFormField(
                      controller: textcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "you must add a task";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {},
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Add to",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GetBuilder<TaskController>(builder: (contoller) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: contoller.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryList(
                            taskCategory: contoller.categories[index],
                          );
                        },
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
