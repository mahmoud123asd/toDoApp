import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/home_controller.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task_category.dart';
import 'home_view.dart';
import 'new_task_view.dart';
import 'report_view.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final HomeController homeController = Get.find();
  final TaskController taskcontroller = Get.find();

  final List<Widget> _screens = [
    HomeView(),
    NewTaskView(),
    ReportView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentIndex = homeController.tabIndex.value;
      final isDeleting = homeController.isDeleting.value;
      final willDelted = homeController.willdelted.value;
      return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: DragTarget<TaskCategory>(
          onWillAccept: (data) {
            homeController.cahngeWillDeleted(true);
            return true;
          },
          onLeave: (data) {
            homeController.cahngeWillDeleted(false);
          },
          onAcceptWithDetails: (DragTargetDetails<TaskCategory> data) {
            taskcontroller.deleteCategory(data.data);
            homeController.changeDeleting(false);
            homeController.willdelted.value = false;
            EasyLoading.showSuccess("Deleted");
          },
          builder: (context, candidateData, rejectedData) => AnimatedContainer(
            decoration: BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.antiAlias,
            duration: Duration(milliseconds: 200),
            width: (isDeleting) ? 80 : 60,
            height: (isDeleting) ? 80 : 60,
            child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: (isDeleting) ? Colors.red : Colors.green,
                elevation: 5,
                onPressed: () => homeController.changeTab(1),
                child: Icon(
                    (isDeleting)
                        ? (willDelted)
                            ? Icons.delete_forever
                            : Icons.delete
                        : Icons.add,
                    size: 30,
                    color: Colors.white)),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          elevation: 8,
          color: Colors.white,
          child: SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.apps,
                    color: currentIndex == 0 ? Colors.green : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () => homeController.changeTab(0),
                ),
                const SizedBox(width: 48), // space for FAB
                IconButton(
                  icon: Icon(
                    Icons.data_usage,
                    color: currentIndex == 2 ? Colors.green : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () => homeController.changeTab(2),
                ),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: currentIndex,
          children: _screens,
        ),
      );
    });
  }
}
