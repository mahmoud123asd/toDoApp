import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task_category.dart';

class CategoryList extends StatelessWidget {
  final TaskCategory taskCategory;
  const CategoryList({super.key, required this.taskCategory});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
      builder: (taskController) => InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          taskController.selectCategory(taskcategory: taskCategory);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(
                IconData(taskCategory.iconCode, fontFamily: 'MaterialIcons'),
                color: Color(taskCategory.colorValue),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                taskCategory.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(
                (taskController.selectedCategory == taskCategory)
                    ? Icons.check
                    : null,
                color: Colors.lightBlue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
