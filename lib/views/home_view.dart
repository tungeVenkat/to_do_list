import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/views/edit_task.dart';
import '../controllers/task_controller.dart';

class HomeView extends StatelessWidget {
  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: controller.sortTasks,
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Due Date', child: Text('Sort by Due Date')),
              PopupMenuItem(value: 'Priority', child: Text('Sort by Priority')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search...', border: OutlineInputBorder()),
              onChanged: controller.searchTasks,
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.taskList.length,
                  itemBuilder: (_, i) {
                    final task = controller.taskList[i];
                    return Card(
                      child: ListTile(
                        title: Text(task.title),
                        subtitle: Text(
                            '${task.priority} | Due: ${task.dueDate.toLocal().toString().split(' ')[0]}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Get.to(() => AddEditTaskView(task: task));
                                }),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () =>
                                    controller.deleteTask(task.id)),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddEditTaskView()),
        child: Icon(Icons.add),
      ),
    );
  }
}
