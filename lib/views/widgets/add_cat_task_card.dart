import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/views/widgets/task_cat_dialog.dart';

class AddCatTaskCard extends StatelessWidget {
  AddCatTaskCard({super.key});
  GlobalKey<FormState> formkey = GlobalKey();
  TaskController taskcontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey.shade400,
      dashPattern: [5, 6],
      strokeWidth: .9,
      child: Center(
        child: IconButton(
            highlightColor: Colors.transparent,
            onPressed: () {
              Get.defaultDialog(
                radius: 10,
                title: "Task Type",
                titlePadding: EdgeInsets.all(10),
                content: Form(key: formkey, child: TaskCatDialog()),
                confirm: MaterialButton(
                  color: darkGreen,
                  textColor: Colors.white,
                  minWidth: 150,
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      String name = taskcontroller.catname;
                      int iconCode = taskcontroller.icondata;
                      int color = taskcontroller.color;
                      taskcontroller.addCategory(name, iconCode, color);
                      Get.back();
                    }
                  },
                  child: Text("Confirm"),
                ),
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.grey,
              size: 40,
            )),
      ),
    );
  }
}
