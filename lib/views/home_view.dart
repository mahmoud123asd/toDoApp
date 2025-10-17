import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/home_controller.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task_category.dart';
import 'package:to_do/views/widgets/add_cat_task_card.dart';
import 'package:to_do/views/widgets/task_card.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final TaskController taskcontroller = Get.find();
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Lists",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
            child: Obx(
              () {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 20),
                  itemCount: taskcontroller.categories.length + 1,
                  itemBuilder: (context, index) {
                    List categories = taskcontroller.categories;
                    if (index == taskcontroller.categories.length) {
                      return AddCatTaskCard();
                    }
                    return LongPressDraggable<TaskCategory>(
                      data: categories[index],
                      onDragStarted: () {
                        homeController.changeDeleting(true);
                      },
                      onDragEnd: (details) =>
                          homeController.changeDeleting(false),
                      onDraggableCanceled: (velocity, offset) =>
                          homeController.changeDeleting(false),
                      feedback: Opacity(
                        opacity: .5,
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: 150, maxHeight: 154),
                          child: TaskCard(
                            category: categories[index],
                          ),
                        ),
                      ),
                      child: TaskCard(
                        category: categories[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}
