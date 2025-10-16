import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do/controllers/home_binding.dart';
import 'package:to_do/models/task_category.dart';
import 'package:to_do/models/task_item.dart';
import 'package:to_do/views/mainlayout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskCategoryAdapter());
  Hive.registerAdapter(TaskItemAdapter());
  await Hive.openBox<TaskCategory>('categories');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      home: MainLayout(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
