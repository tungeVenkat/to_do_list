import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class AddEditTaskView extends StatefulWidget {
  final TaskModel? task;

  AddEditTaskView({this.task});

  @override
  _AddEditTaskViewState createState() => _AddEditTaskViewState();
}

class _AddEditTaskViewState extends State<AddEditTaskView> {
  final _formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  String priority = 'Low';
  DateTime dueDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleCtrl.text = widget.task!.title;
      descCtrl.text = widget.task!.description;
      priority = widget.task!.priority;
      dueDate = widget.task!.dueDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    final isEdit = widget.task != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Task' : 'Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleCtrl,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: descCtrl,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              DropdownButtonFormField<String>(
                value: priority,
                items: ['Low', 'Medium', 'High']
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: (val) => setState(() => priority = val!),
                decoration: InputDecoration(labelText: 'Priority'),
              ),
              ListTile(
                title: Text('Due Date: ${dueDate.toLocal().toString().split(' ')[0]}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => dueDate = picked);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(isEdit ? 'Update Task' : 'Add Task'),
                onPressed: () {
                  final task = TaskModel(
                    id: isEdit ? widget.task!.id : Uuid().v4(),
                    title: titleCtrl.text,
                    description: descCtrl.text,
                    priority: priority,
                    dueDate: dueDate,
                  );

                  if (isEdit) {
                    controller.updateTask(task);
                  } else {
                    controller.addTask(task);
                  }

                  Get.back();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
