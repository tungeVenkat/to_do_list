import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/views/edit_task.dart';
import '../controllers/task_controller.dart';

class HomeView extends StatelessWidget {
  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'ToDo List',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.cyanAccent,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.grey[900],
            icon: Icon(Icons.sort, color: Colors.cyanAccent),
            onSelected: controller.sortTasks,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Due Date',
                child: Text(
                  '📅 Sort by Due Date',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const PopupMenuItem(
                value: 'Priority',
                child: Text(
                  '⚡ Sort by Priority',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              cursorColor: Colors.tealAccent, // <-- Cursor color here

              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '🔍 Search...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
              ),
              onChanged: controller.searchTasks,
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.taskList.length,
                  itemBuilder: (_, i) {
                    final task = controller.taskList[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Colors.cyan.withOpacity(0.2),
                              Colors.deepPurple.withOpacity(0.2),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border:
                              Border.all(color: Colors.cyanAccent, width: 0.5),
                        ),
                        child: ListTile(
                          title: Text(
                            task.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                          subtitle: Text(
                            '${task.priority} | Due: ${task.dueDate.toLocal().toString().split(' ')[0]}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.amberAccent),
                                  onPressed: () {
                                    Get.to(() => AddEditTaskView(task: task));
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () =>
                                      controller.deleteTask(task.id)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 30,
            right: 25,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.6),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Colors.cyanAccent,
                elevation: 12,
                onPressed: () => Get.to(() => AddEditTaskView()),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
