import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/constants/icons.dart';
import 'package:to_do/controllers/task_controller.dart';

class TaskCatDialog extends StatelessWidget {
  TaskCatDialog({
    super.key,
  });
final  TaskController taskcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onChanged: (newValue) {
            taskcontroller.catname = newValue;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "you must enter type";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            labelText: "title",
            labelStyle: TextStyle(color: Colors.blue),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        GetX<TaskController>(
          init: TaskController(),
          builder: (controller) => Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: 5,
            children: iconsdata.entries.map((entry) {
              final icon = entry.key;
              final color = entry.value;

              final isSelected =
                  controller.selectedIconCode.value == icon.codePoint;

              return GestureDetector(
                onTap: () {
                  controller.selectedIconCode.value = icon.codePoint;
                  taskcontroller.icondata = icon.codePoint;
                  taskcontroller.color = color.value;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(3),
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.grey
                        : Colors.transparent, // highlight selected
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 1,
                            )
                          ]
                        : [],
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : color,
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
