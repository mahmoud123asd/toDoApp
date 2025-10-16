import 'package:get/get.dart';
import 'package:to_do/controllers/home_controller.dart';
import 'package:to_do/controllers/task_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(TaskController());
  }
}
