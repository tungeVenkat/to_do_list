import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';
import '../controllers/task_controller.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final controller = Get.find<TaskController>();

  TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text('${task.priority} | Due: ${task.dueDate.toLocal().toString().split(' ')[0]}'),
      onTap: () => Get.toNamed('/add', arguments: task),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => controller.deleteTask(task.id),
      ),
    );
  }
}
