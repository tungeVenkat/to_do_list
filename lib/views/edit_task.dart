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
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isEdit ? 'Edit Task' : 'Add Task',
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.cyanAccent),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.cyanAccent.withOpacity(0.4)),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildInputField(titleCtrl, 'Title', Icons.title),
                const SizedBox(height: 12),
                _buildInputField(descCtrl, 'Description', Icons.description),
                const SizedBox(height: 12),

                // 🎯 Modern Dropdown
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.grey[900],
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.cyan.withOpacity(0.1),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: priority,
                    icon: const Icon(Icons.arrow_drop_down,
                        color: Colors.cyanAccent),
                    dropdownColor: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                    decoration: InputDecoration(
                      labelText: 'Priority',
                      labelStyle: const TextStyle(color: Colors.cyanAccent),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      prefixIcon:
                          const Icon(Icons.bolt, color: Colors.cyanAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    items: ['Low', 'Medium', 'High']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,
                                  style: const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => priority = val!),
                  ),
                ),

                const SizedBox(height: 12),

                // 📅 Date Picker
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Colors.white.withOpacity(0.05),
                  title: Text(
                    'Due Date: ${dueDate.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(Icons.calendar_today,
                      color: Colors.cyanAccent),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: dueDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: ColorScheme.dark(
                              primary: Colors.cyanAccent,
                              onPrimary: Colors.black,
                              surface: Colors.grey[900]!,
                              onSurface: Colors.white,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) setState(() => dueDate = picked);
                  },
                ),

                const SizedBox(height: 24),

                // ✅ Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isEdit ? 'Update Task' : 'Add Task',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    final task = TaskModel(
                      id: isEdit ? widget.task!.id : const Uuid().v4(),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.cyanAccent,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(label, icon: icon),
    );
  }

  InputDecoration _inputDecoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.cyanAccent),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      prefixIcon: icon != null ? Icon(icon, color: Colors.cyanAccent) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
