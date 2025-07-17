import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/task_controller.dart';
import 'views/home_view.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await NotificationService.initialize(); initialize notifications
  Get.put(TaskController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeView(),
  ));
}
