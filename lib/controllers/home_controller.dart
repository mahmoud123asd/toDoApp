import 'package:get/get.dart';
//import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeController extends GetxController {
  // PersistentTabController tabcontroller =
  //     PersistentTabController(initialIndex: 0);
  RxInt tabIndex = 0.obs;
  RxBool isDeleting = false.obs;
  void changeTab(int i) => tabIndex.value = i;
  // void homeindex() {
  //   tabcontroller.index = 0;
  // }
  void changeDeleting(bool value) {
    isDeleting.value = value;
  }
}
