// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:to_do/controllers/home_controller.dart';
// import 'package:to_do/views/home_view.dart';
// import 'package:to_do/views/new_task_view.dart';
// import 'package:to_do/views/report_view.dart';

// class MainLayout extends StatefulWidget {
//   const MainLayout({super.key});

//   @override
//   State<MainLayout> createState() => _MainLayoutState();
// }

// class _MainLayoutState extends State<MainLayout> {
//   final HomeController homecontroller = Get.find();
//   late PersistentTabController controller;
//   @override
//   void initState() {
//     controller = homecontroller.tabcontroller;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       backgroundColor: Colors.white,
//       navBarStyle: NavBarStyle.style15,
//       resizeToAvoidBottomInset: true,
//       hideNavigationBarWhenKeyboardAppears: true,
//       stateManagement: true,
//       items: [
//         PersistentBottomNavBarItem(
//             icon: Icon(Icons.apps),
//             activeColorPrimary: Colors.green,
//             inactiveColorPrimary: Color(0xff999999)),
//         PersistentBottomNavBarItem(
//             icon: Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//             activeColorPrimary: Colors.green,
//             inactiveColorPrimary: Color(0xff999999)),
//         PersistentBottomNavBarItem(
//             icon: Icon(Icons.data_usage),
//             activeColorPrimary: Colors.green,
//             inactiveColorPrimary: Color(0xff999999)),
//       ],
//       controller: controller,
//       context,
//       screens: [
//         HomeView(),
//         NewTaskView(),
//         ReportView(),
//       ],
//     );
//   }
// }

// main_layout.dart