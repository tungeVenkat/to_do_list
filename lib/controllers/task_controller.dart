import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';
import '../services/notification_service.dart';

class TaskController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var taskList = <TaskModel>[].obs;
  List<TaskModel> allTasks = [];

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    firestore.collection('tasks').snapshots().listen((event) {
      allTasks = event.docs
          .map((doc) => TaskModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      taskList.value = allTasks;
    });
  }

  void addTask(TaskModel task) async {
    await firestore.collection('tasks').doc(task.id).set(task.toMap());

    // NotificationService.scheduleNotification(
    //   id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    //   title: "Task Reminder",
    //   body: "${task.title} is due soon!",
    //   scheduledDate:
    //       task.dueDate.subtract(Duration(minutes: 30)), // 30 min before due
    // );
  }

  void updateTask(TaskModel task) async {
    await firestore.collection('tasks').doc(task.id).update(task.toMap());
  }

  void deleteTask(String id) async {
    await firestore.collection('tasks').doc(id).delete();
  }

  void searchTasks(String keyword) {
    if (keyword.isEmpty) {
      taskList.value = allTasks;
    } else {
      taskList.value = allTasks
          .where((task) =>
              task.title.toLowerCase().contains(keyword.toLowerCase()) ||
              task.description.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
  }

  void sortTasks(String sortBy) {
    if (sortBy == 'Due Date') {
      taskList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } else if (sortBy == 'Priority') {
      taskList.sort((a, b) => a.priority.compareTo(b.priority));
    }
    taskList.refresh();
  }
}
