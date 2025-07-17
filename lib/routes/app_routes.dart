import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/edit_task.dart';
class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => HomeView()),
    GetPage(name: '/add', page: () => AddEditTaskView()),
  ];
}
